function [result] = ScrewInspection(imgpath, visualization)

    length_std = 68;
    width_std = 39;
    length_thr = 7;
    width_thr = 3;
    thread_num = 8;
    inner_d_std = 60;
    out_d_std = 75;
    d_thr = 2;
    thread_h = 7.5;
    thread_h_thr = 0.5;
    load('contour_template.mat');

    img = imread(imgpath); img = imrotate(img,-90);img = imresize(img,0.1);
    [line,im_patch,bw_patch] = findScrew(img);
    [boundary] = extractBoundary(bw_patch);
    contour = [boundary(:,2),boundary(:,1)];
    [angle,length_scale,width_scale] = getAngleNScale(contour);
    if abs(angle)>0.1
        [R,t,contour,matches] = icp2d(contour,contour_template);
        c_minx = min(contour(:,1)); c_miny = min(contour(:,2));
        if c_minx <0
            contour(:,1)=contour(:,1)-c_minx;
            t(1) = t(1)-c_minx+1;
        end
        if c_miny <0
            contour(:,2)=contour(:,2)-c_miny;
            t(2) = t(2)-c_miny+1;
        end

        H =[R,t;0 0 1];
        bw_patch=warpH(bw_patch,H,size(bw_patch));
        d = sqrt((contour(matches(:,1),1)-contour_template(matches(:,2),1)).^2 + ...
            (contour(matches(:,1),2)-contour_template(matches(:,2),2)).^2);
        contour(matches(d>mean(d),1),:) = contour_template(matches(d>mean(d),2),:);
        contour = contour(matches(:,1),:);
        line = [min(contour_template(:,1)),min(contour_template(:,2)),max(contour_template(:,1)),max(contour_template(:,2))];
        line = ceil(line);
        if size(bw_patch,1)>line(4)-line(2)
        bw_patch = bw_patch(line(2):line(4),:);
        end
        if size(bw_patch,2)>line(3)-line(1)
        bw_patch = bw_patch(:,line(1):line(3));
        end
        [boundary] = extractBoundary(bw_patch);
        contour = [boundary(:,2),boundary(:,1)];
        [~,length_scale,width_scale] = getAngleNScale(contour);
%         figure;
%         imshow(bw_patch);hold on;
%         plot(contour(:,1),contour(:,2));
    end

% check screw length and width
    length_err = length_scale-length_std;
    if abs(length_err) > length_thr
    	if length_err>0
    		result = 'too long';
    		return;
    	else
    		result = 'too short';
    		return;
    	end
    end

    width_err = width_scale-width_std;
    if abs(width_err) > width_thr
    	if width_err>0
    		result = 'too fat';
    		return;
    	else
    		result = 'too skinny';
    		return;
    	end
    end

    % check screw head
    bw_head = bw_patch(1:20,:);
    [bound_head] = extractBoundary(bw_head);
    head_area = polyarea(bound_head(:,2),bound_head(:,1));
    if head_area>1200
        result = 'big head';
        return;
    end
    if head_area<900
        result = 'small head';
        return;
    end

    % check screw thread

    thread_part = [10 138];
    contour(contour(:,2)>thread_part(2)|contour(:,2)<thread_part(1),:)=[];
    [in_l, in_r, out_l, out_r] = findExtrema(contour);
    % need to be improved\


    if min([size(in_l,1),size(in_r,1),size(out_l,1),size(out_r,1)])<thread_num
    	result = 'thread missing';
    	return;
	end

% 	[inner_matches,~] = threadpointMatch(in_l,in_r,thread_num);
% 	[out_matches,~] = threadpointMatch(out_l,out_r,thread_num);
%
% 	inner_d = abs(in_l(inner_matches(:,1),1) - in_r(inner_matches(:,2),1));
% 	out_d = abs(out_l(out_matches(:,1),1)-out_r(out_matches(:,2),1));
%
% 	if sum(abs(inner_d(3:end-1) - inner_d_std)>d_thr)>0 || sum(abs(out_d(3:end-1) - out_d_std)>d_thr)>0
% 		result = 'problem screw thread';
% 		return;
% 	end

	[thread_l,~] = threadpointMatch(in_l,out_l,thread_num);
	[thread_r,~] = threadpointMatch(in_r,out_r,thread_num);

	left_d = abs(in_l(thread_l(:,1),1) - out_l(thread_l(:,2),1));
	right_d = abs(in_r(thread_r(:,1),1) - out_r(thread_r(:,2),1));

	if sum(abs(left_d(3:end-1) - thread_h)>thread_h_thr)>1 || sum(abs(right_d(3:end-1) - thread_h)>thread_h_thr)>1
		result = 'problem screw thread';
		return;
	end

	result = 'good screw';


end
