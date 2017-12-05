function [im_patch,bw_patch] = findScrewHead(imgpath)
% line [min_x,min_y,max_x,max_y]
    img = imread(imgpath);
    img = imrotate(img,-90);
    img = imresize(img,0.1);
[bw] = backgroundSubtract(img,0.3);
CC = bwconncomp(bw);
max_conn = 0;
for i = 1:numel(CC.PixelIdxList)
 if numel(CC.PixelIdxList{i})>max_conn
     max_conn = numel(CC.PixelIdxList{i});
     conn_ind = i;
 end
end

pixels = CC.PixelIdxList{conn_ind};
bw = zeros(size(bw));
bw(pixels) = 1;
[pix_y,pix_x] = ind2sub(size(bw),pixels);
line = [min(pix_x),min(pix_y),max(pix_x),max(pix_y)];

bw_patch = bw(line(2):line(4),line(1):line(3));
im_patch = img(line(2):line(4),line(1):line(3));

bw_patch = bw_patch(1:15,:);
im_patch = im_patch(1:15,:);
% 
% imshow(img);hold on;
% rectangle('Position',[line(1),line(2),line(3)-line(1),line(4)-line(2)],'EdgeColor','g');hold on;
end
