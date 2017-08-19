%% MyMainScript

tic;
%% Your code here
input = load('../data/lionCrop.mat');
input = input.imageOrig;
input = myLinearContrastStretching(input);

output = myUnsharpMasking(input,2,2.5);
output = myLinearContrastStretching(output);

subplot(1,2,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(1,2,2), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress



input = load('../data/superMoonCrop.mat');
input = input.imageOrig;
input = myLinearContrastStretching(input);

output = myUnsharpMasking(input,2,3);
output = myLinearContrastStretching(output);

subplot(1,2,1) , imshow(input, 'InitialMagnification', 'fit'), title('input image'),
axis on,colorbar
subplot(1,2,2), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

toc;

execution_time = toc