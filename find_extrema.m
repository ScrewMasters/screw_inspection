% load '../wait2befiltered.mat'
for i=1:24
[contour] = readandshow(strcat('../screws_images/screw1_',num2str(i),'.jpg'));
%find the x axis middle point
avg_x = sum(contour(:,1))/length(contour);

% split the contour into two parts
contour_right = contour(contour(:,1) > avg_x, :);
contour_left = contour(contour(:,1) < avg_x, :);

% transpose the contour
c_r = [contour_right(:,2), contour_right(:,1)];
c_l = [contour_left(:,2), contour_left(:,1)];

% smooth the contour
windowSize = 1;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
c_r_y = filter(b,a,c_r(:,2));
c_l_y = filter(b,a,c_l(:,2));

% find extremas
[c_r_ymax,c_r_imax,c_r_ymin,c_r_imin] = extrema(c_r_y);
[c_l_ymax,c_l_imax,c_l_ymin,c_l_imin] = extrema(c_l_y);
% 
[inliers,k,b]=ransacLine([c_l_ymin, c_l(c_l_imin, 1)]);
c_l_ymin = c_l_ymin(inliers);
c_l_imin = c_l_imin(inliers);

[inliers,k,b]=ransacLine([c_l_ymax, c_l(c_l_imax, 1)]);
c_l_ymax = c_l_ymax(inliers);
c_l_imax = c_l_imax(inliers);

[inliers,k,b]=ransacLine([c_r_ymin, c_r(c_r_imin, 1)]);
c_r_ymin = c_r_ymin(inliers);
c_r_imin = c_r_imin(inliers);

[inliers,k,b]=ransacLine([c_r_ymax, c_r(c_r_imax, 1)]);
c_r_ymax = c_r_ymax(inliers);
c_r_imax = c_r_imax(inliers);



subplot(1, 3, 2);
plot(c_r(:,1), c_r_y);
hold on;
plot(c_r(:,1), c_r(:,2));
scatter(c_r(c_r_imax, 1), c_r_ymax, 'g','filled');
scatter(c_r(c_r_imin, 1), c_r_ymin, 'r','filled');
axis equal;

subplot(1, 3, 1);
plot(c_l(:,1), c_l_y);
hold on;
plot(c_l(:,1), c_l(:,2));
scatter(c_l(c_l_imax, 1), c_l_ymax, 'g','filled');
scatter(c_l(c_l_imin, 1), c_l_ymin, 'r','filled');
axis equal;

subplot(1, 3, 3);
plot(contour(:,1), contour(:,2));
hold on;
scatter(c_r_ymax, c_r(c_r_imax, 1), 'g','filled');
scatter(c_r_ymin, c_r(c_r_imin, 1), 'r','filled');
scatter(c_l_ymax, c_l(c_l_imax, 1), 'g','filled');
scatter(c_l_ymin, c_l(c_l_imin, 1), 'r','filled');
axis equal;
hold off;
waitforbuttonpress;
end