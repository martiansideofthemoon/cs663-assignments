%% MyMainScript

tic;
%% Your code here
input1 = load('../data/lionCrop.mat');
input1 = input1.imageOrig;
output1 = myUnsharpMasking(input1,2,3);

input2 = load('../data/superMoonCrop.mat');
input2 = input2.imageOrig;
output2 = myUnsharpMasking(input2,3,3);

colormap(gray)
%plotting image lion
subplot(1,2,1),subimage(input1)
colorbar
subplot(1,2,2),subimage(output1)
colorbar

%press any button to see second image
waitforbuttonpress 

%plotting second moon
subplot(1,2,1),subimage(input2)
colorbar
subplot(1,2,2),subimage(output2)
colorbar

toc;
