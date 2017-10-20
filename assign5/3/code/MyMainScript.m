
%% Load Image
load('../data/image_low_frequency_noise.mat');
fim = fftshift(fft2(Z));
absfim = log(abs(fim) + 1);
figure
subplot(1,2,1)
imshow(Z)
axis on, colorbar
subplot(1,2,2)
imshow(absfim, [1, 16])
axis on, colorbar, waitforbuttonpress
%% Notch Filtering
% The fourier transform indicates high frequency component at (119,124) and (139,134)
% This was determined using find(13 < absfim & 14 > absfim)
% We construct 5*5 notch filters at these locations to remove low frequency noise
fim2 = fim;
% filter size is (2*dim+1) * (2*dim+1)
dim = 2;
for i=-dim:dim
    for j=-dim:dim
        fim2(119 + i, 124 + j) = 0;
        fim2(139 + i, 134 + j) = 0;
    end
end
absfim2 = log(abs(fim2) + 1);
img2 = ifft2(ifftshift(fim2));
figure
subplot(1,2,1)
imshow(img2)
axis on, colorbar
subplot(1,2,2)
imshow(absfim2, [1,16])
axis on, colorbar, waitforbuttonpress

