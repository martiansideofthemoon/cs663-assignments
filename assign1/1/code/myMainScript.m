%% MyMainScript

tic;
%% Your code here
%% Setup

%% Shrinking images
input = imread('../data/circles_concentric.png');
output_two = myShrinkImageByFactorD(input, 2);
output_three = myShrinkImageByFactorD(input, 3);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(output_two, 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress
imshow(output_three, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress

%% Bilinear Interpolation
input = imread('../data/barbaraSmall.png');
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
output_near = myBilinearInterpolation(input);
imshow(uint8(output_near), 'InitialMagnification', 'fit')
axis on, colorbar, pause

%% Nearest Neighbours
input = imread('../data/barbaraSmall.png');
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
output_near = myNearestNeighborInterpolation(input);
imshow(uint8(output_near), 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
