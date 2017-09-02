function output = myMeanShiftSegmentation(img, bw_color, bw_spatial, iterations)
    [rows, cols, channels] = size(img);
    estimates = img;

    bw_color_sq = bw_color * bw_color;
    bw_spatial_sq = bw_spatial * bw_spatial;
    window_size = 3 * bw_spatial;
    index_array = zeros(rows, cols, 2);
    for i = 1:rows
        for j = 1:cols
            index_array(i, j, :) = [i j];
        end
    end

    for i = 1:rows
        for j = 1:cols
            % Defintion of the window
            % We are using this window size since the spatial values almost zero beyond 3*sigma
            window_left = max(1, j - window_size);
            window_right = min(cols, j + window_size);
            window_top = max(1, i - window_size);
            window_down = min(rows, i + window_size);
            spatial_window = index_array(window_top:window_down, window_left:window_right, :);
            color_window = img(window_top:window_down, window_left:window_right, :);

            spatial_exp = buildGaussKernel(spatial_window, index_array(i, j, :), bw_spatial_sq);
            for t = 1:iterations
                color_exp = buildGaussKernel(color_window, estimates(i, j, :), bw_color_sq);
                kernel = color_exp .* spatial_exp;
                mean_value = computeMean(color_window, kernel, channels);
                estimates(i, j, :) = mean_value;
            end
        end
    end
    output = estimates;
end


function output = buildGaussKernel(img, center, variance)
    temp1 = bsxfun(@minus, img, center);
    temp1 = sum(temp1 .^ 2, 3);
    output = exp(-temp1 / (2 * variance));
end


function output = computeMean(img, kernel, channels)
    scaled_img = double(img);
    for i = 1:channels
        scaled_img(:, :, i) = scaled_img(:, :, i) .* kernel;
    end
    numerator = sum(sum(scaled_img, 1), 2);
    denominator = sum(sum(kernel));
    output = numerator / denominator;
end
