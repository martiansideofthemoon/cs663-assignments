%% MyMainScript

tic;
%% Your code here

input = load('../data/barbara.mat');
input = input.imageOrig;
output = myPatchBasedFiltering(input, 1.5, 1.5);

toc