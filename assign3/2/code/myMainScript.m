%% MyMainScript

tic;
%% Your code here
input = imread('../data/baboonColor.png');
% Gaussian blurring with sigma = 1
input = imgaussfilt(input, 1);
% Subsampling by factor of 2
input = input(1:4:end , 1:4:end, :);
output = myMeanShiftSegmentation(input, 2, 2, 10);
toc
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(output, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress