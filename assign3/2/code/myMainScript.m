%% MyMainScript

tic;
%% Your code here
input = imread('../data/baboonColor.png');
input = im2double(input);
% Gaussian blurring with sigma = 1
input = imgaussfilt(input, 1);
% Subsampling by factor of 2
input = input(1:2:end , 1:2:end, :);
output = myMeanShiftSegmentation(input, 0.1, 10, 15);
% Carrying out the binning process
num_bins = 8;
output_bin = round(output * num_bins) / num_bins;
toc
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(output, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(output_bin, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress