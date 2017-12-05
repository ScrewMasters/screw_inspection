function [R,t,pts1,matches] = icp2d(pts1,pts2)
%f1,f2 feature points N1x2 N2x2
% Rf1+t =f2
T = eye(3);
[R, t] = getInitialGuess(pts1, pts2);
pts1  = (R*pts1' + t)';
% pts1  = (R*(pts1'-mean(pts1)')+mean(pts1)' + t)';
T  = [R,t;0 0 1]*T;
%find closet point 
[matches,mean_d] = closestpointMatch(pts1,pts2);
pre_d= Inf;
i=0;
while abs(pre_d-mean_d)>0.001&&i<25
i=i+1;
pre_d = mean_d;    
% rigid body transformation
%[R,t] = similaritywarp(pts1(matches(:,1),:),pts2(matches(:,2),:));
[R,t] = euclideanwarp2d(pts1(matches(:,1),:),pts2(matches(:,2),:));
% H2to1 = computeH(pts2(matches(:,2),:)',pts1(matches(:,1),:)');

% T = H2to1*T;
T  = [R,t;0 0 1]*T;
pts1  = (R*pts1' + t)';

% pts1 = H2to1*[pts1,ones(size(pts1(:,1)))]';
% pts1 = pts1';pts1 = pts1(:,1:2);

%find closet point 
[matches,mean_d] = closestpointMatch(pts1,pts2);
% fprintf('ICP iter: %d, mean dis: %f\n',i,mean_d);
end

R = T(1:2,1:2);
t = T(1:2,3);


end

