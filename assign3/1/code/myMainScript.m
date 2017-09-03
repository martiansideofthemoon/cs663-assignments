%% MyMainScript
%% Your code here
tic;
input = load('../data/boat.mat');
input = input.imageOrig;
input = mat2gray(input);
input = imgaussfilt(input, 0.6);
input = im2double(input);

sigma = 0.6;
sigma_window = 0.8;
k = 0.05;
threshold = 0.3;

[Ix, Iy, eigen1, eigen2, score, output] = myHarrisCornerDetector(input, k, sigma, sigma_window, threshold);
% figure,
% subplot(2,1,1) , imshow(Ix, 'InitialMagnification', 'fit'), title('derivative along X'),
% axis on,colorbar
% subplot(2,1,2), imshow(Iy, 'InitialMagnification', 'fit'),title('derivative along Y')
% axis on,colorbar, waitforbuttonpress
% 
imshow(eigen1, 'InitialMagnification', 'fit'), title('eigen1')
axis on, colorbar, waitforbuttonpress
imshow(eigen2, 'InitialMagnification', 'fit'), title('eigen2')
axis on, colorbar, waitforbuttonpress
% 
imshow(score, 'InitialMagnification', 'fit'),title('corner-ness')
axis on, colorbar, waitforbuttonpress

imshow(output, 'InitialMagnification', 'fit'),title('output')
axis on, colorbar, waitforbuttonpress
toc