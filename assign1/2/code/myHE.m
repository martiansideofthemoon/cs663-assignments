function output = myHE(img)
    [h, w] = size(img);
    total = h * w;
    [counts, locations] = imhist(img);
    % This is the grayscale map, a monotonic function
    map = zeros(256);
    cumulative = 0.0;
    i = 1:256
    cumulative = cumsum(counts(i));
    map = 256.0 * (cumulative ./ total);
    for i = 1:h
        for j = 1:w
            output(i, j) = map(img(i, j)+1);
        end
    end
end