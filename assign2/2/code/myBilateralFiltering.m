function output = myBilateralFiltering(img,w,sigma_spatial,sigma_intensity)

%UNTITLED Summary of this function goes here
%random noise to the image
img = mat2gray(img);

corrupted =  img + 0.05 * randn(size(img));
%   Detailed explanation goes here
%computing spatial gaussian window  
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_spatial^2));

% Create waitbar.
h = waitbar(0,'Applying bilateral filter...');
set(h,'Name','Bilateral Filter Progress');

dim = size(corrupted);
output = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = corrupted(iMin:iMax,jMin:jMax);
      
         % Compute Gaussian intensity weights.
         H = exp(-(I-corrupted(i,j)).^2/(2*sigma_intensity^2));
      
         % Calculate bilateral filter response.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         output(i,j) = sum(F(:).*I(:))/sum(F(:));
               
   end
   waitbar(i/dim(1));
end

% Close waitbar.
close(h);
save('output', 'output')

rmsd = sqrt((1 / (dim(1) * dim(2)) * (sum(sum((output - img) * (output - img))))));
dim(1)  
rmsd
sigma_spatial
sigma_intensity

figure(1);
subplot(1,3,1), imshow(img, 'InitialMagnification', 'fit'),title('input image')
axis on,colorbar
subplot(1,3,2), imshow(corrupted, 'InitialMagnification', 'fit'),title('corrupted image')
axis on,colorbar
subplot(1,3,3), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar

end


