function output = myShrinkImageByFactorD(img, d)
    temp = downsample(img, d);
    output = downsample(temp', d)';
end