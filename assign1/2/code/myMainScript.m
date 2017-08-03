%% MyMainScript

tic;
%% Your code here
%% Setup

%% Linear constrast stretching
input = imread('../data/barbara.png');
output = myLinearContrastStretching(input);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myLinearContrastStretching(input);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myLinearContrastStretching(input(:, :, i));
end
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

%% Histogram Equalization
input = imread('../data/barbara.png');
output = myHE(input);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myHE(input);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myHE(input(:, :, i));
end
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

%% Adaptive Histogram Equalization
input = imread('../data/barbara.png');
output = myAHE(input, 20);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myAHE(input, 20);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myAHE(input(:, :, i), 20);
end
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

%% Contrast Limited Adaptive Histogram Equalization
input = imread('../data/barbara.png');
output = myCLAHE(input, 20, 0.1);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myCLAHE(input, 20, 0.1);
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myCLAHE(input(:, :, i), 20, 0.1);
end
% Displaying images, press any key to continue
imshow(input, 'InitialMagnification', 'fit')
axis on, colorbar, waitforbuttonpress
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress