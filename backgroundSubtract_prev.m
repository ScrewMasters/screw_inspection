function [bw] = backgroundSubtract_prev(img)
    if numel(size(img))==3
        img = rgb2gray(img);
    end
    thr = (max(img(:))-min(img(:)) 2+min(img(:));

    bw = zeros(size(img,1),size(img,2));
    bw(img<thr) = 1;
    
end

