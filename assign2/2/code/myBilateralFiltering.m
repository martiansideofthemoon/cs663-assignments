function output = myBilateralFiltering(img)
%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

%%finding the range of intensities of the image
maxValue = max(img(:));
minValue = min(img(:));
range = maxValue - minValue;

%%standard deviation for gauusian blur
stndev = 0.05 * range;

%%applying gaussian blur
win_size = 10
windowVector = gausswin(win_size,1/stndev);
sum = 0;
windowMatrix = windowVector * windowVector';

for i=1:win_size
    for j=1:win_size
        sum = sum + windowMatrix(i,j);
    end
end
gb_img = conv2(windowVector,windowVector',img);     %gaussian blurred image
gb_img = gb_img./sum;   %to normalise the intensities

end


