function [score,c1_interp,c2_interp,y_uniform] = compareBoundaries(c1,c2)


[~,ind] = sort(c1(:,2));
c1 = c1(ind,:);

[~,ind] = sort(c2(:,2));
c2 = c2(ind,:);

centroid1 = [mean(c1(:,1)),mean(c1(:,2))];
centroid2 = [mean(c2(:,1)),mean(c2(:,2))];

c1_upp = c1(c1(:,1)<centroid1(1),:);
c2_upp = c2(c2(:,1)<centroid2(1),:);

[~,ia,~] = unique(c1_upp(:,2));
c1_upp = c1_upp(ia,:);
[~,ia,~] = unique(c2_upp(:,2));
c2_upp = c2_upp(ia,:);

y_uniform = (min(c1(:,2))+5):1:(max(c1(:,2))-5);

c1_interp = interp1(c1_upp(:,2),c1_upp(:,1),y_uniform');
c2_interp = interp1(c2_upp(:,2),c2_upp(:,1),y_uniform');

score = c1_interp-c2_interp;

end
