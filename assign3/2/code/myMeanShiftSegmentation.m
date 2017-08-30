function output = myMeanShiftSegmentation(img, bw_color, bw_spatial, iterations)
    [rows, cols, channels] = size(img);
    estimates = img;

    bw_color_sq = bw_color * bw_color;
    bw_spatial_sq = bw_spatial * bw_spatial;

    index_array = zeros(rows, cols, 2);
    for i = 1:rows
        for j = 1:cols
            index_array(i, j, :) = [i j];
        end
    end

    for t = 1:iterations
        for i = 1:rows
            for j = 1:cols
                color_exp = buildGaussKernel(img, estimates(i, j, :), bw_color_sq);
                spatial_exp = buildGaussKernel(index_array, [i, j], bw_spatial_sq);
                kernel = color_exp .* spatial_exp;
                mean_value = computeMean(img, kernel, channels);
                estimates(i, j, :) = mean_value;
            end
        end
    end
    output = estimates;
end


function output = buildGaussKernel(img, center, variance)
    temp1 = bsxfun(@minus, img, center);
    temp1 = sum(temp1 .^ 2, 3);
    output = exp(-temp1 / variance);
end



function output = computeMean(img, kernel, channels)
    scaled_img = img;
    for i = 1:channels
        scaled_img(:, :, i) = scaled_img(:, :, i) .* kernel;
    end
    numerator = sum(sum(scaled_img, 1), 1);
    denominator = sum(sum(kernel));
    output = numerator / denominator;
end