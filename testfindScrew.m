% find screws and boundaries

img1 = imread('../image/screw1.jpg');
img2 = imread('../image/screw2.jpg');
img3 = imread('../image/screw3.jpg');
[line1,bw1] = findScrew(img1);
[line2,bw2] = findScrew(img2);
[line3,bw3] = findScrew(img3);

im_patch1 = img1(line1(2):line1(4),line1(1):line1(3));
im_patch2 = img2(line2(2):line2(4),line2(1):line2(3));
im_patch3 = img3(line3(2):line3(4),line3(1):line3(3));

[boundary1] = extractBoundary(bw1); [boundary2] = extractBoundary(bw2);[boundary3] = extractBoundary(bw3);
c1 = [boundary1(:,2),boundary1(:,1),ones(size(boundary1(:,1)))];
c2 = [boundary2(:,2),boundary2(:,1),ones(size(boundary2(:,1)))];
c3 = [boundary3(:,2),boundary3(:,1),ones(size(boundary3(:,1)))];

M12 = LucasKanadeAffine_c(imresize(im_patch1,size(im_patch2)), im_patch2); 
w1 = warpH(imresize(bw1,size(bw2)),M12,size(bw2));boundarybw = extractBoundary(w1);
% plot(boundary1(:,2),boundary1(:,1));hold on; 
plot(boundary2(:,2),boundary2(:,1));hold on ;plot(boundarybw(:,2),boundarybw(:,1));hold on;legend('2','bw')
hold on; scatter([sum(boundary2(:,2))./numel(boundary2(:,2)),sum(boundarybw(:,2))./numel(boundarybw(:,2))],[sum(boundary2(:,1))./numel(boundary2(:,1)),sum(boundarybw(:,1))./numel(boundarybw(:,1))]);
% M32 = LucasKanadeAffine_c(imresize(im_patch3,size(im_patch2)), im_patch2); 
% w3 = warpH(imresize(bw3,size(bw2)),M12,size(bw2));boundarybw = extractBoundary(w3);
% plot(boundary3(:,2),boundary3(:,1));hold on; plot(boundary2(:,2),boundary2(:,1));hold on ;plot(boundarybw(:,2),boundarybw(:,1));hold on;legend('3','2','bw')

% [filterResponses1] = extractFilterResponses(im_patch1, filterBank);
% 
% for i=1:20
% a(:,:,:,i) = filterResponses1(:,:,3*i-2:3*i);
% end
% montage(a,'size',[4,5])