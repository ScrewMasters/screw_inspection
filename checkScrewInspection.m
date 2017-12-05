% result_normal= cell(24,1);
% for i = 1:24
% result = ScrewInspection(strcat('../screws_images/screw1_',num2str(i),'.jpg'));
% result_normal{i}=result;
% end
% 
% result_glue = cell(24,1);
% for i = 1:24
% result = ScrewInspection(strcat('../screws_images/screw_glue_',num2str(i),'.jpg'));
% result_glue{i}=result;
% end
% 
% result_scratch = cell(24,1);
% for i = 1:24
% result = ScrewInspection(strcat('../screws_images/screw_scratch_',num2str(i),'.jpg'));
% result_scratch{i}=result;
% end
% 
% result_heatshrink= cell(24,1);
% for i = 1:24
% result = ScrewInspection(strcat('../screws_images/screw_heatshrink_',num2str(i),'.jpg'));
% result_heatshrink{i}=result;
% end
% 
% % result_short= cell(24,1);
% % for i = 1:24
% % result = ScrewInspection(strcat('../screws_images/screw_short_',num2str(i),'.jpg'));
% % result_short{i}=result;
% % end
% 
% result_headscratch= cell(23,1);
% for i = 1:23
% result = ScrewInspection(strcat('../screws_images/screw_headscratch_',num2str(i),'.jpg'));
% result_headscratch{i}=result;
% end
% 
% result_tilt= cell(9,1);
% for i = 1:9
% result = ScrewInspection(strcat('../screws_images/screw_tilted_',num2str(i),'.jpg'));
% result_tilt{i}=result;
% end

result_normal2= cell(24,1);
for i = 1:24
result = ScrewInspection(strcat('../screws_images_2/screw2_',num2str(i),'.jpg'));
result_normal2{i}=result;
end

result_normal3= cell(24,1);
for i = 1:24
result = ScrewInspection(strcat('../screws_images_2/screw3_',num2str(i),'.jpg'));
result_normal3{i}=result;
end

result_normal4= cell(24,1);
for i = 1:24
result = ScrewInspection(strcat('../screws_images_2/screw4_',num2str(i),'.jpg'));
result_normal4{i}=result;
end

result_tissue= cell(24,1);
for i = 1:24
result = ScrewInspection(strcat('../screws_images_2/screw_tissue_',num2str(i),'.jpg'));
result_tissue{i}=result;
end

result_tin= cell(23,1);
for i = 1:23
result = ScrewInspection(strcat('../screws_images_2/screw_tin_',num2str(i),'.jpg'));
result_tin{i}=result;
end

result_tinyscratch= cell(24,1);
for i = 1:24
result = ScrewInspection(strcat('../screws_images_2/screw_tinyscratch_',num2str(i),'.jpg'));
result_tinyscratch{i}=result;
end