function [contour,bw] = readandshow(imgpath)
    img = imread(imgpath);
    img = imrotate(img,-90);
    img = imresize(img,0.1);
    %img = imgaussfilt(img,0.3);
%     se = strel('ball',1,1);
%     img = imerode(img,se);img = imdilate(img,se);
    [line,~,bw] = findScrew(img);
    %[boundary] = extractBoundary(bw(1:138,:));
    [boundary] = extractBoundary(bw);
    contour = [boundary(:,2),boundary(:,1)];
   % contour(contour(:,2)>138|contour(:,2)<12,:)=[];
% contour(contour(:,2)>15,:)=[];
%bw = bw(1:15,:);
    %imshow(bw);hold on;
%     plot(contour(:,1),contour(:,2),'.');hold on;
end
    