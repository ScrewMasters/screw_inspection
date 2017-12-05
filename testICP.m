% img1 = imread('../image/screw1.jpg');
% img2 = imread('../image/screw2.jpg');
% img3 = imread('../image/screw3.jpg');
% im_f1 = imread('../image/fake_damage_screw1.jpg');
% im_f2 = imread('../image/fake_damage_screw2.jpg');
% img1 = imresize(img1,0.4);
% img2 = imresize(img2,0.4);
% img3 = imresize(img3,0.4);
% im_f1 = imresize(im_f1,0.4);
% im_f2 = imresize(im_f2,0.4);
% 
% [c_f,im_patch_f] = getScrewContour(im_f2);
% [c,im_patch] = getScrewContour(img1);

[c,bw_t] = readandshow('../screws_images/screw1_1.jpg');
[c_f,bw] = readandshow('../screws_images/screw_tilted_6.jpg');

centroid_f = [mean(c_f(:,1)),mean(c_f(:,2))];
centroid = [mean(c(:,1)),mean(c(:,2))];

% c_f = c_f(c_f(:,1)<centroid_f(1),:);
% c = c(c(:,1)<centroid(1),:);
% [R, t] = getInitialGuess(c_f, c);
%  c_f  = (R*(c_f'-mean(c_f)') +mean(c_f)'+t)';
% 
[R,t,c_f_new,matches] = icp2d(c_f,c);

d = sqrt((c_f_new(matches(:,1),1)-c(matches(:,2),1)).^2 + (c_f_new(matches(:,1),2)-c(matches(:,2),2)).^2);
c_f_new(matches(d>2*d(ceil(numel(d)/2)),1),:) = c(matches(d>2*d(ceil(numel(d)/2)),2),:);
% c_f_new  = (R*c_f'+t)';
c_f_new = c_f_new(matches(:,1),:);
% plot(c_f(:,1),c_f(:,2),'.');hold on;plot(c(:,1),c(:,2),'.');

plot(c_f_new(:,1),c_f_new(:,2),'.');hold on;plot(c(:,1),c(:,2),'.');



