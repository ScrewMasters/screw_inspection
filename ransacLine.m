function [best_inliers] = ransacLine(pts)

N = size(pts,1);
err = 2;
best_num = 0;
nIter = 20;
% for i=1:nIter
%     x1 = pts(i,1); y1 = pts(i,2);
%
%     dis = abs(pts(:,1)-x1);
%     inliers = find(dis<err);
%     num = numel(inliers);
%
%     if best_num < num
%         best_num = num;
%         best_inliers = inliers;
%     end
% end
%
% x = pts(best_inliers,1);
% y = pts(best_inliers,2);
% c = pinv([x,ones(size(x))])*y;
% d = abs(c(1)*pts(:,1) -pts(:,2)+c(2));
% [~,index] = sort(d);
% best_inliers = index(1:N);

for i = 1 : nIter
    r = randperm(N,2);
    x = pts(r,1);
    y = pts(r,2);
    c = pinv([x,ones(size(x))])*y;
    d = abs(c(1)*pts(:,1) -pts(:,2)+c(2))/sqrt(c(1)^2+1);

    inliers = find(d < err);
    num = numel(inliers);

    if best_num < num
        best_num = num;
        best_inliers = inliers;
    end
end
%     Y = pts(best_inliers,2);
%     X = [pts(best_inliers,1),ones(size(Y))];
%     c = pinv(X)*Y;
%     A = c(1); C = c(2);
%
%     %avg dis of inliers
%     avg_dis = sum(abs((c(1)*X_r+c(2)*Y_r+c(3)-Z_r))/sqrt(c(1)^2+c(2)^2+1))/numel(Z_r);

end
