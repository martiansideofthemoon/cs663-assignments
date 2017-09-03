%% MyMainScript
%% Your code here
tic;
input = load('../data/boat.mat');
input = input.imageOrig;
input = mat2gray(input);
input = imgaussfilt(input, 0.2);
input = im2double(input);

% This sigma is used to smooth Ix, Iy, Ixy
sigma = 0.5;
% This `k` is used in "determinant - k * trace * trace"
k = 0.15;
% This threshold is used over cornerness measure
threshold = 0.011;

[Ix, Iy, eigen1, eigen2, score, output, output2] = myHarrisCornerDetector(input, k, sigma, threshold);
% figure,
imshow(Ix, 'InitialMagnification', 'fit'), title('derivative along X'),
axis on,colorbar
imshow(Iy, 'InitialMagnification', 'fit'),title('derivative along Y')
axis on,colorbar, waitforbuttonpress
imshow(eigen1, 'InitialMagnification', 'fit'), title('eigen1')
axis on, colorbar, waitforbuttonpress
imshow(eigen2, 'InitialMagnification', 'fit'), title('eigen2')
axis on, colorbar, waitforbuttonpress
% 
imshow(score, 'InitialMagnification', 'fit'),title('corner-ness')
axis on, colorbar, waitforbuttonpress

imshow(output, 'InitialMagnification', 'fit'),title('output')
axis on, colorbar, waitforbuttonpress

imshow(output2, 'InitialMagnification', 'fit'),title('output2')
axis on, colorbar, waitforbuttonpress
toc