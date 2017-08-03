function output = myBilinearInterpolation(img)
    [h, w] = size(img);
    out_w = 2 * w - 1;
    out_h = 3 * h - 2;
    output = zeros(out_h, out_w);
    scale_h = out_h / h;
    scale_w = out_w / w;
    for i=1:out_h
        for j=1:out_w
            % This is relative position of pixel in old image
            relative_y = i / scale_h;
            relative_x = j / scale_w;
            % "upper" only refers to a higher magnitude
            % upper_y is the nearest higher indexed pixel in old image
            upper_y = ceil(relative_y);
            % max() is taken to account for first index
            lower_y = max(1, upper_y - 1);
            % del_y is fractional position of pixel with respect to bounding box
            del_y = max(0.0, relative_y - lower_y);

            % Similar computation of columns
            upper_x = ceil(relative_x);
            lower_x = max(1, upper_x - 1);
            del_x = max(0.0, relative_x - lower_x);

            % Actual bilinear interpolation code
            output(i, j) = ...
                img(lower_y, lower_x) * (1 - del_x) * (1 - del_y) + ...
                img(upper_y, lower_x) * (1 - del_x) * (del_y) + ...
                img(lower_y, upper_x) * (del_x) * (1 - del_y) + ...
                img(upper_y, upper_x) * (del_x) * (del_y);
        end
    end
end