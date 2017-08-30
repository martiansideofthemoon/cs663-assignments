%% MyMainScript

tic;
%% Your code here
input = imread('../data/baboonColor.png');
% Gaussian blurring with sigma = 1
input = imgaussfilt(input, 1);
% Subsampling by factor of 2
input = input(1:2:end , 1:2:end, :);
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
toc;