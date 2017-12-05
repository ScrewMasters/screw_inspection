function [inliers] = lineRegression(pts,N)

if N>=size(pts,1)
    inliers = pts;
    return;
end

x = pts(:,1);
y = pts(:,2);
c = pinv([x,ones(size(x))])*y;
d = abs(c(1)*x -y+c(2));
[~,index] = sort(d);
inliers = pts(index(1:N),:);

end

