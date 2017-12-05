function [matches,mean_d] = closestpointMatch(pts1,pts2)

N1 = size(pts1,1); N2 = size(pts2,1);
poll1 = 1:N1; poll2 = 1:N2;
matches = zeros(min([N1,N2]),2);
d = zeros(min([N1,N2]),1);
%D N1 x N2
D = pdist2(pts1,pts2);
i=1;
while ~isempty(D)
    [cur_d,min_ind] = min(D(:));
    [ind_1,ind_2] = ind2sub(size(D),min_ind);
    matches(i,:) = [poll1(ind_1),poll2(ind_2)];
    poll1(ind_1)=[]; poll2(ind_2)=[];
    D(ind_1,:) =[];
    D(:,ind_2) = [];
    d(i) = cur_d;
    i=i+1;
end

mean_d = mean(d);
% outliers = d>1.5*mean_d;
% matches(outliers,:)=[];
% d(outliers) = [];
% mean_d = mean(d);

end

