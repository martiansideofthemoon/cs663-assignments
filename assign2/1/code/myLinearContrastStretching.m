function LCS_output = myLinearContrastStretching(img)
    img = double(img);
    maximum = max(img(:));
    minimum = min(img(:));
    [h, w] = size(img);
    for i = 1:h
        for j = 1:w
            LCS_output(i, j) = (img(i, j) - minimum) * 1.0 / (maximum - minimum);
        end
    end
end