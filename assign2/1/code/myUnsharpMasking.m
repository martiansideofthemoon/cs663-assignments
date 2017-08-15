function output = myUnsharpMasking(img,sd,sp)
%
gaussian = imgaussfilt(img,sd);%sd - deviation of gaussian blur
mask = img - gaussian;
output = img + sp*mask;%sp - scaling parameter

end

