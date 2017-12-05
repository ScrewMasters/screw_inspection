
 [c,bw_t] = readandshow('../screws_images/screw1_1.jpg');
% [c_f,bw] = readandshow('../screws_images/screw_tilted_6.jpg');

% [R,t,c_f_new,matches] = icp2d(c_f,c);
thread_part = [10 138];
c(c(:,2)>thread_part(2)|c(:,2)<thread_part(1),:)=[];
[in_l, in_r, out_l, out_r] = findExtrema(c);
N=9;
% [in_l] = lineRegression(in_l,N);
% [in_r] = lineRegression(in_r,N);
% [out_l] = lineRegression(out_l,N);
% [out_r] = lineRegression(out_r,N);

plot(c(:,1),c(:,2)); hold on;
scatter(in_l(:,1),in_l(:,2),'filled'); hold on;
scatter(in_r(:,1),in_r(:,2),'filled'); hold on;
scatter(out_l(:,1),out_l(:,2),'filled'); hold on;
scatter(out_r(:,1),out_r(:,2),'filled'); hold off;
