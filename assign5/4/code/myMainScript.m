%% Original Image
img = imread('../data/barbara256.png');
[rows, cols] = size(img);
% Padding array 2 times
img2 = padarray(img, [rows/2, cols/2]);
fim = fftshift(fft2(img2));
absfim = log(abs(fim) + 1);
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
% Original unpadded image shown for convenience
imshow(img)
axis on, colorbar
subplot(1,2,2)
imshow(absfim, [0, 16])
axis on, colorbar, waitforbuttonpress


%% Ideal, D = 40 - Filters
close(handles.H)
mask = fspecial('disk', 40);
indices = find(mask > 0);
mask(indices) = 1;
[r_mask, c_mask] = size(mask);
mask = padarray(mask, [(2*rows - r_mask + 1)/2,(2*cols - c_mask + 1)/2]);
mask = mask(1:2*rows, 1:2*cols);
fim2 = fim .* mask;
absfim2 = log(abs(fim2) + 1);
img3 = real(ifft2(ifftshift(fim2)));
% Extracting only central portion
img3 = img3(rows/2+1:3*rows/2, cols/2+1:3*cols/2);
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1)
imshow(absfim, [0, 16])
axis on, colorbar
subplot(1,3,2)
imshow(mask, [0, 1])
axis on, colorbar
subplot(1,3,3)
imshow(absfim2, [0, 16])
axis on, colorbar, waitforbuttonpress
%% Output Images
close(handles.H)
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img)
axis on, colorbar
subplot(1,2,2)
imshow(img3, [0, 256])
axis on, colorbar, waitforbuttonpress


%% Ideal, D = 80 - Filters
close(handles.H)
mask = fspecial('disk', 80);
indices = find(mask > 0);
mask(indices) = 1;
[r_mask, c_mask] = size(mask);
mask = padarray(mask, [(2*rows - r_mask + 1)/2,(2*cols - c_mask + 1)/2]);
mask = mask(1:2*rows, 1:2*cols);
fim2 = fim .* mask;
absfim2 = log(abs(fim2) + 1);
img3 = real(ifft2(ifftshift(fim2)));
% Extracting only central portion
img3 = img3(rows/2+1:3*rows/2, cols/2+1:3*cols/2);
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1)
imshow(absfim, [0, 16])
axis on, colorbar
subplot(1,3,2)
imshow(mask, [0, 1])
axis on, colorbar
subplot(1,3,3)
imshow(absfim2, [0, 16])
axis on, colorbar, waitforbuttonpress
%% Output Images
close(handles.H)
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img)
axis on, colorbar
subplot(1,2,2)
imshow(img3, [0, 256])
axis on, colorbar, waitforbuttonpress


%% Gaussian, S = 40 - Filters
close(handles.H)
mask = fspecial('gaussian', 512, 40);
% Fixing scale of mask
mask = mask * (1 / mask(256,256));
fim2 = fim .* mask;
absfim2 = log(abs(fim2) + 1);
img3 = real(ifft2(ifftshift(fim2)));
% Extracting only central portion
img3 = img3(rows/2+1:3*rows/2, cols/2+1:3*cols/2);
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1)
imshow(absfim, [0, 16])
axis on, colorbar
subplot(1,3,2)
imshow(mask, [0, 1])
axis on, colorbar
subplot(1,3,3)
imshow(absfim2, [0, 16])
axis on, colorbar, waitforbuttonpress
%% Output Images
close(handles.H)
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img)
axis on, colorbar
subplot(1,2,2)
imshow(img3, [0, 256])
axis on, colorbar, waitforbuttonpress


%% Gaussian, S = 80
close(handles.H)
mask = fspecial('gaussian', 512, 80);
% Fixing scale of mask
mask = mask * (1 / mask(256,256));
fim2 = fim .* mask;
absfim2 = log(abs(fim2) + 1);
img3 = real(ifft2(ifftshift(fim2)));
% Extracting only central portion
img3 = img3(rows/2+1:3*rows/2, cols/2+1:3*cols/2);
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1)
imshow(absfim, [0, 16])
axis on, colorbar
subplot(1,3,2)
imshow(mask, [0, 1])
axis on, colorbar
subplot(1,3,3)
imshow(absfim2, [0, 16])
axis on, colorbar, waitforbuttonpress
%% Output Images
close(handles.H)
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img)
axis on, colorbar
subplot(1,2,2)
imshow(img3, [0, 256])
axis on, colorbar, waitforbuttonpress