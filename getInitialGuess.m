function [R, t] = getInitialGuess(pts1, pts2)
% get the transformation between two set of points, pnt2' = R * pts1' + t
% input:
% pts1: Nx2 
% pts2: Nx2
    center1 = mean(pts1);
    center2 = mean(pts2);
    t = center2 - center1; t=t';
    
    [coeff1,~,latent1] = pca(pts1); [coeff2,~,latent2] = pca(pts2);
    scale = sqrt(latent2(2,1)/latent1(2,1));
    v1 = coeff1(:,1); v2 = coeff2(:,1);
    x1 = v1(1);y1 = v1(2);x2=v2(1);y2=v2(2);
    % angle 1=>2 counter clockwise
    a = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
    a = a*pi/180;
    R = [cos(a),-sin(a);sin(a),cos(a)];%*scale;
    
end