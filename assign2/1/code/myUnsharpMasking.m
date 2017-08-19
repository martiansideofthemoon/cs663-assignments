function unSharp_output = myUnsharpMasking(img,sd,sp)
%
gaussian = imgaussfilt(img,sd);%sd - deviation of gaussian blur
mask = img - gaussian;
unSharp_output = img + sp*mask;%sp - scaling parameter

end
