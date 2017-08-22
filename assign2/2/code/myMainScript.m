%% MyMainScript

tic;
%% Your code here
img = load('../data/barbara.mat');
img = img.imageOrig;
output = myBilateralFiltering(img,12,0.9,1.3);

toc;
