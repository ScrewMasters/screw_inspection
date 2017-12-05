function [bw] = backgroundSubtract(img, thd)
  % load background images
  if nargin < 2
    thd = 0.3;
  end
  if exist('avg_background.mat', 'file') == 2
    load('avg_background.mat');
  else
    myDir = uigetdir; %gets directory
    myFiles = dir(fullfile(myDir,'background*.jpg'));
    num_background = length(myFiles);
    img_size = size(rgb2gray(imread(strcat(myDir,'/', myFiles(1).name))));
    avg_background = zeros(img_size);
    for i = 1 : num_background
      img = im2double(rgb2gray(imread(strcat(myDir,'/', myFiles(i).name))));
      avg_background = avg_background + img;
    end
    avg_background = avg_background / num_background;
    save('avg_background.mat', 'avg_background');
  end
  avg_background = imrotate(avg_background,-90);
  img = im2double(rgb2gray(img));
  avg_background = imresize(avg_background,size(img));
  img = img - avg_background;
  bw = abs(img) > thd;
end
