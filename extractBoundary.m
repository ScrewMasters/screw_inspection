function [boundary] = extractBoundary(bw)
    B = bwboundaries(bw);
    max_b = 0;
    
    for i =1:numel(B)
        if numel(B{i})>max_b
            max_b = numel(B{i});
            max_ind  = i;
        end
    end
    
    boundary = B{max_ind};

end

