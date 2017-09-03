%% MyMainScript

tic;
%% Your code here

input = load('../data/boat.mat');
input = input.imageOrig;
output = myHarrisCornerDetector(input);


toc;
