function [contour] = getScrewContour(img)
   [line,bw] = findScrew(img);
   [boundary] = extractBoundary(bw);
   contour = [boundary(:,2),boundary(:,1)];
end