function [R,t] = similaritywarp(pts1,pts2)
N = size(pts1,1);
x = pts2'; x = x(:);
A = zeros(2*N,4);
A(1:2:end-1,:) = [pts1,ones(N,1),zeros(N,1)];
A(2:2:end,:) = [-pts1(:,2),pts1(:,1),zeros(N,1),ones(N,1)];
p = pinv(A)*x;
R = [p(1),p(2);-p(2),p(1)];
t = [p(3);p(4)];
end

