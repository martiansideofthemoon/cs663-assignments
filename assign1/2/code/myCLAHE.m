function output = myCLAHE(img, N, clip)
    [h, w] = size(img);
    for i = 1:h
        for j = 1:w
            % Building window for AHE
            lower_y = max(1, i - N);
            upper_y = min(h, i + N);
            lower_x = max(1, j - N);
            upper_x = min(w, j + N);
            img_box = img(lower_y:upper_y, lower_x:upper_x);
            % Obtaining histogram equalized grayscale maps
            map = getHistMap(img_box, clip);
            output(i, j) = map(img(i, j) + 1);
        end
    end
end

function map = getHistMap(img, clip)
    [h, w] = size(img);
    total = h * w;
    [counts, locations] = imhist(img);
    % Clip the histogram and redistribute mass
    clip_limit = total * clip;
    clipped_pixels = 0;
    i = 1:256
        if counts(i) > clip_limit
            clipped_pixels = cumsum(counts(i) - clip_limit);
            counts(i) = clip_limit;
    
    end
    % Uniformly spreading mass across histogram
    per_bin = clipped_pixels / 256.0;
    for i = 1:256
        counts(i) = counts(i) + floor(per_bin);
        clipped_pixels = clipped_pixels - floor(per_bin);
        per_bin = clipped_pixels / (256.0 - i);
    end

    % This is the grayscale map, a monotonic function
    map = zeros(256);
    cumulative = 0.0;
    i = 1:256
    cumulative = cumsum(counts(i));
    map = 256.0 * (cumulative ./ total);
    
end