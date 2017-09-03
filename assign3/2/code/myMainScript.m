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
% This is an approximate way to constraint the image to lesser colors

num_bins = 8;
output_bin = round(output * num_bins) / num_bins;

toc

subplot(1,2,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(1,2,2), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

subplot(1,2,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(1,2,2), imshow(output_bin, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

