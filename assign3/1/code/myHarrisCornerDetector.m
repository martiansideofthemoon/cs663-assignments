function [Ix, Iy, eigen1, eigen2, score, output, output2] = myHarrisCornerDetector(img, k, sigma, threshold)

    width = size(img,1);
    height = size(img,2);

    dx = [-1 0 1; -2 0 2; -1 0 1];	 % vertical derivative mask
    dy = [-1 -2 -1; 0 0 0; 1 2 1];	 % horizontal derivative mask

    window = fspecial('gaussian', [5, 5], sigma);

    % We don't need a loop since a convolution is equivalent to the weight summation
    Ix = conv2(img, dx, 'same');
    Iy = conv2(img, dy, 'same');
    Ixx = conv2(Ix .* Ix, window, 'same');
    Iyy = conv2(Iy .* Iy, window, 'same');
    Ixy = conv2(Ix .* Iy, window, 'same');

    % `output` is the marked result without non-maximal supression
    output = zeros(height, width, 3);
    % `output2` is the marked result with non-maximal supression
    output2 = zeros(height, width, 3);
    for i=1:3
        output(:, :, i) = img;
        output2(:, :, i) = img;
    end

    % `score` denotes the cornerness
    score = zeros(width, height);

    determinant = Ixx .* Iyy - Ixy .^ 2;
    tr = Ixx + Iyy;
    tr_by_2 = tr / 2;
    eigen1 = tr_by_2 - ((tr_by_2 .^ 2 - determinant) .^ (0.5));
    eigen2 = tr_by_2 + ((tr_by_2 .^ 2 - determinant) .^ (0.5));
    score = determinant - k * (tr .^ 2);


    % Additionally, we threshold the cornerness
    for i = 1:width
        for j = 1:height
            if score(i, j) > threshold
                output = insertMarker(output, [j, i]);
            end
        end
    end

    % Implementing non-maximal suppression of window size 3
    supp_window = 3;
    for i = 1:supp_window:width-supp_window+1
        for j = 1:supp_window:height-supp_window+1
            values = score(i:i+supp_window-1, j:j+supp_window-1);
            [maximum argmax] = max(values(:));
            [x y] = ind2sub(size(values), argmax);
            if maximum > threshold
                output2 = insertMarker(output2, [j+y-1, i+x-1]);
            end
        end
    end

end
