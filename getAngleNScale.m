function [angle,length_scale,width_scale] = getAngleNScale(pts)
    [coeff,~,latent] = pca(pts); 
    length_scale = sqrt(latent(1,1));
    width_scale = sqrt(latent(2,1));
    v1 = coeff(:,1); 
    x1 = v1(1);y1 = v1(2);x2=0;y2=1;
    % angle 1=>2 counter clockwise /rad
    a = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
    angle = a*pi/180;
end

