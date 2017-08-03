function output = myHE(img)
    [h, w] = size(img);
    total = h * w;
    [counts, locations] = imhist(img);
    map = zeros(256);
    cumulative = 0.0;
    for i = 1:256
        cumulative = cumulative + counts(i);
        map(i) = 256.0 * (cumulative / total);
    end
    for i = 1:h
        for j = 1:w
            output(i, j) = map(img(i, j) + 1);
        end
    end
end