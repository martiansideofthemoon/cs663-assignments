function output = myPatchBasedFiltering(img, sigmaSpatial, sigmaIntensity)%
%sigmaSpatial = sigmaSpatial*1.1;
%sigmaIntensity = sigmaIntensity*1.1;
img = mat2gray(img);
input_image = img;
img = imgaussfilt(img,0.66);
img = img(1:2:end , 1:2:end);
corrupted =  img + 0.05 * randn(size(img));

in_rows = size(corrupted,1);
in_cols = size(corrupted,2);

windowsize = 25;
patchsize = 9;

w = (windowsize - 1) / 2; % half windowsize
p = (patchsize - 1) / 2;  % half patchsize

num = zeros(in_rows,in_cols);
den = zeros(in_rows,in_cols);

for i = 1:in_rows
    % Limiting patch in Y direction
    ipMin = max(i - p, 1);
    ipMax = min(i + p, in_rows);
    % Limiting window in Y direction
    iMin = max(i - w, 1);
    iMax = min(i + w, in_rows);

    for j = 1:in_cols
        % These matrices will be used to compute new pixel value
        spacialDiff = zeros(windowsize, windowsize);
        expPatchDiff = zeros(windowsize, windowsize);
        window = zeros(windowsize, windowsize);

        % Limiting patch in X direction
        jpMin = max(j - p, 1);
        jpMax = min(j + p, in_cols);
        % Limiting window in X direction
        jMin = max(j - w, 1);
        jMax = min(j + w, in_cols);

        % As defined above, the original patch lies in (ipMin, ipMax) and (jpMin, jpMax)
        patch2 = zeros(patchsize, patchsize);
        % We define the relative position of patches with repect to (i, j)
        % (p + 1) denotes the center pixel
        ipRelMin = (p + 1) + (ipMin - i);
        ipRelMax = (p + 1) + (ipMax - i);
        jpRelMin = (p + 1) + (jpMin - j);
        jpRelMax = (p + 1) + (jpMax - j);
        patch2(ipRelMin:ipRelMax, jpRelMin:jpRelMax) = corrupted((ipMin:ipMax), (jpMin:jpMax));

        % Loop over every pixel in the window around (i, j)
        for i1 = iMin:iMax
            % Limiting neighbourhood patch in Y direction
            i1Min = max(i1 - p, 1);
            i1Max = min(i1 + p, in_rows);

            for j1 = jMin:jMax
                % Limiting neighbourhood patch in X direction
                j1Min = max(j1 - p, 1);
                j1Max = min(j1 + p, in_cols);

                window((i1 - iMin + 1),(j1 - jMin + 1)) = corrupted(i1, j1);
                spacialDiff((i1-iMin + 1), (j1 - jMin + 1)) = (i - i1)*(i - i1) +(j - j1)*(j - j1);

                % As defined above, the neighbourhood patch lies in (ipMin, ipMax) and (jpMin, jpMax)
                patch1 = zeros(patchsize, patchsize);
                % We define the relative position of patches with repect to (i1, j1)
                % (p + 1) denotes the center pixel
                i1RelMin = (p + 1) + (i1Min - i1);
                i1RelMax = (p + 1) + (i1Max - i1);
                j1RelMin = (p + 1) + (j1Min - j1);
                j1RelMax = (p + 1) + (j1Max - j1);
                patch1(i1RelMin:i1RelMax, j1RelMin:j1RelMax) = corrupted((i1Min:i1Max), (j1Min:j1Max));

                patchDiff = 0;
                % This range is the overlapping section between two patches
                xRangeLower = max(ipRelMin, i1RelMin);
                xRangeHigher = min(ipRelMax, i1RelMax);
                yRangeLower = max(jpRelMin, j1RelMin);
                yRangeHigher = min(jpRelMax, j1RelMax);
                for x = xRangeLower:xRangeHigher
                    for y = yRangeLower:yRangeHigher
                        patchDiff = patchDiff + (((patch1(x,y) - patch2(x,y))*(patch1(x,y) - patch2(x,y))) / (sigmaIntensity*sigmaIntensity));
                    end;
                end;
                expPatchDiff((i1 - iMin + 1),(j1 - jMin + 1)) = exp(patchDiff*(-1));
            end;
        end;
        % p pixel is at location i,j

        gsSpacial = exp((spacialDiff * (-0.5)) / (sigmaSpatial * sigmaSpatial)); %Cg matrix
        % expPatchDiff is Cs matrix
        t = gsSpacial.*expPatchDiff;
        num(i,j) = sum(sum(window.*t));
        den(i,j) = sum(sum(t));
    end;

end;
output = num./den;
save('output', 'output')

rmsd = sqrt((1 / (in_rows * in_cols)) * (sum(sum((img - output) * (img - output)))));
rmsd
sigmaSpatial
sigmaIntensity

figure(1);
subplot(1,3,1), imshow(input_image, 'InitialMagnification', 'fit'),title('input image')
subplot(1,3,2), imshow(corrupted, 'InitialMagnification', 'fit'),title('corrupted image')
subplot(1,3,3), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

figure(2);
imshow(num, 'InitialMagnification', 'fit'),title('mask')


end
