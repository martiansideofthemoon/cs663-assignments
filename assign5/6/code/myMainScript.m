%% MyMainScript
tic;

%% Load Input, Add noise
sigma = 20;
img = double(imread('../data/barbara256.png'));
img1 = img + randn(size(img))*sigma;
mse_error_orig = sqrt(immse(img, img1))
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img/255)
axis on, colorbar
subplot(1,2,2)
imshow(img1/255)
axis on, colorbar, waitforbuttonpress

%% Bilateral Filtering
% After a grid-search of about 100 settings, we obtained -
% w = 4, sigma_spatial = 1.2, sigmal_intensity = 43
close(handles.H)
img2 = myBilateralFiltering(img1, 4, 1.2, 43);
mse_error_bilateral = sqrt(immse(img, img2))
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img1/255)
axis on, colorbar
subplot(1,2,2)
imshow(img2/255)
axis on, colorbar, waitforbuttonpress

%% PCA Denoising - 1
close(handles.H)
img2 = myPCADenoising1(img1, sigma);
mse_error_pca = sqrt(immse(img, img2))
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img1/255)
axis on, colorbar
subplot(1,2,2)
imshow(img2/255)
axis on, colorbar, waitforbuttonpress

%% PCA Denoising - 2
close(handles.H)
img2 = myPCADenoising2(img1, sigma);
mse_error_pca2 = sqrt(immse(img, img2))
handles.H = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(img1/255)
axis on, colorbar
subplot(1,2,2)
imshow(img2/255)
axis on, colorbar, waitforbuttonpress
toc;
