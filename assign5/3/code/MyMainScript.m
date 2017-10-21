
%% Load Image
load('../data/image_low_frequency_noise.mat');
[rows, cols] = size(Z);
% Padding array 2 times
Z2 = padarray(Z, [rows/2, cols/2]);
fim = fftshift(fft2(Z2));
absfim = log(abs(fim) + 1);
figure
subplot(1,2,1)
% Original unpadded image shown for convenience
imshow(Z/255)
axis on, colorbar
subplot(1,2,2)
imshow(absfim, [1, 16])
axis on, colorbar, waitforbuttonpress
%% Notch Filtering
% The fourier transform indicates high frequency component at (237,247) and (277,267)
% This was determined using find(13 < absfim & 14 > absfim)
% We construct 11*11 notch filter pass regions at these locations to remove low frequency noise
fim2 = fim;
% filter size is (2*dim+1) * (2*dim+1)
dim = 5;
for i=-dim:dim
    for j=-dim:dim
        fim2(237 + i, 247 + j) = 0;
        fim2(277 + i, 267 + j) = 0;
    end
end
absfim2 = log(abs(fim2) + 1);
img2 = real(ifft2(ifftshift(fim2)));
% Extracting only central portion
img2_show = img2(rows/2+1:3*rows/2, cols/2+1:3*cols/2);
figure
subplot(1,2,1)
imshow(img2_show/255)
axis on, colorbar
subplot(1,2,2)
imshow(absfim2, [1,16])
axis on, colorbar, waitforbuttonpress

