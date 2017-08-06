%% MyMainScript

tic;
%% Your code here
%% Setup

%% Linear constrast stretching
input = imread('../data/barbara.png');
output = myLinearContrastStretching(input);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myLinearContrastStretching(input);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myLinearContrastStretching(input(:, :, i));
end
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress


%% Histogram Equalization
input = imread('../data/barbara.png');
output = myHE(input);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress



input = imread('../data/TEM.png');
output = myHE(input);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myHE(input(:, :, i));
end
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

%% Adaptive Histogram Equalization
input = imread('../data/barbara.png');
output = myAHE(input, 40);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress
output = myAHE(input, 10);
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress
output = myAHE(input, 100);
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress


input = imread('../data/TEM.png');
output = myAHE(input, 25);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress
output = myAHE(input, 10);
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress
output = myAHE(input, 100);
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress


input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myAHE(input(:, :, i), 100);
end
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myAHE(input(:, :, i), 10);
end
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress
for i=1:3
    output(:, :, i) = myAHE(input(:, :, i), 200);
end
imshow(uint8(output), 'InitialMagnification', 'fit')
axis on,colorbar, waitforbuttonpress


%% Contrast Limited Adaptive Histogram Equalization
input = imread('../data/barbara.png');
output = myCLAHE(input, 40, 0.5);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

output = myCLAHE(input, 40, 0.5);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

input = imread('../data/TEM.png');
output = myCLAHE(input, 20, 0.3);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

output = myCLAHE(input, 20, 0.3);
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress



input = imread('../data/canyon.png');
output = zeros(size(input));
for i=1:3
    output(:, :, i) = myCLAHE(input(:, :, i), 20, 1);
end
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

output = zeros(size(input));
for i=1:3
    output(:, :, i) = myCLAHE(input(:, :, i), 20, 1);
end
% Displaying images, press any key to continue
subplot(2,1,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(2,1,2), imshow(uint8(output), 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress
