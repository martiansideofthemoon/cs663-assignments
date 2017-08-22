%% MyMainScript

tic;
%% Your code here
img = load('../data/barbara.mat');
img = img.imageOrig;
output = myBilateralFiltering(img,12,1.1,1.16);

toc;
