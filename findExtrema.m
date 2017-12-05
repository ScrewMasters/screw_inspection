function [in_l, in_r, out_l, out_r] = findExtrema(contour)
  %find the x axis middle point
  avg_x = sum(contour(:,1))/length(contour);

  % split the contour into two parts
  contour_right = contour(contour(:,1) > avg_x, :);
  contour_left = contour(contour(:,1) < avg_x, :);

  % transpose the contour
  c_r = [contour_right(:,2), contour_right(:,1)];
  c_l = [contour_left(:,2), contour_left(:,1)];

  % smooth the contour
  windowSize = 2;
  b = (1/windowSize)*ones(1,windowSize);
  a = 1;
  c_r_y = filter(b,a,c_r(:,2));
  c_l_y = filter(b,a,c_l(:,2));

  % find extremas
  [c_r_ymax,c_r_imax,c_r_ymin,c_r_imin] = extrema(c_r_y);
  [c_l_ymax,c_l_imax,c_l_ymin,c_l_imin] = extrema(c_l_y);
  
  inliers = ransacLine([c_r_ymax, c_r(c_r_imax, 1)]);
  c_r_imax = c_r_imax(inliers);
  c_r_ymax = c_r_ymax(inliers);
  inliers = ransacLine([c_r_ymin, c_r(c_r_imin, 1)]);
  c_r_imin = c_r_imin(inliers);
  c_r_ymin = c_r_ymin(inliers);
  inliers = ransacLine([c_l_ymax, c_l(c_l_imax, 1)]);
  c_l_imax = c_l_imax(inliers);
  c_l_ymax = c_l_ymax(inliers);
  inliers = ransacLine([c_l_ymin, c_l(c_l_imin, 1)]);
  c_l_imin = c_l_imin(inliers);
  c_l_ymin = c_l_ymin(inliers);
  
  out_r = sortrows([c_r_ymax, c_r(c_r_imax, 1)], 2, 'descend');
  in_r = sortrows([c_r_ymin, c_r(c_r_imin, 1)], 2, 'descend');
  in_l = sortrows([c_l_ymax, c_l(c_l_imax, 1)], 2, 'descend');
  out_l = sortrows([c_l_ymin, c_l(c_l_imin, 1)], 2, 'descend');
end
