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
