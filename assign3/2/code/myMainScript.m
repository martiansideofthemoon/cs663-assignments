%% MyMainScript

tic;
%% Your code here
input = imread('../data/baboonColor.png');
% Gaussian blurring with sigma = 1
input = imgaussfilt(input, 1);
% Subsampling by factor of 2
input = input(1:2:end , 1:2:end, :);
output = myMeanShiftSegmentation(input, 5, 5, 10);
toc
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(output, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress