%% MyMainScript

tic;
%% Your code here

%% Shrinking images
input = imread('../data/circles_concentric.png');
output_two = myShrinkImageByFactorD(input, 2);
output_three = myShrinkImageByFactorD(input, 3);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification','fit')
axis on, colorbar, waitforbuttonpress
imshow(output_two, 'InitialMagnification','fit')
axis on,colorbar, waitforbuttonpress
imshow(output_three, 'InitialMagnification','fit')
axis on, colorbar

%% Bilinear Interpolation

%% Nearest Neighbours
