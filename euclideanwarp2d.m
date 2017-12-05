function [R,t] = euclideanwarp2d(pts1,pts2)
% pts(x,y) Nx2 
% Rpts1 + t = pts2;
% R 2x2 
% t 2x1

c1 = [mean(pts1(:,1)),mean(pts1(:,2))]; 
c2 = [mean(pts2(:,1)),mean(pts2(:,2))];

p1 = pts1 -c1; p2 = pts2 - c2;
A = p1'*p2;
[U,~,V] = svd(A);

R = V*[1 0;0 det(V*U')]*U';
t = c2' - R*c1';

end

