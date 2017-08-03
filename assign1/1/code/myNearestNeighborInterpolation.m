function output = myNearestNeighborInterpolation(img)
    [h, w] = size(img);
    out_w = 2 * w - 1;
    out_h = 3 * h - 2;
    output = zeros(out_h, out_w);
    scale_h = out_h / h;
    scale_w = out_w / w;
    for i=1:out_h
        for j=1:out_w
            % Determine nearest neighbours by rounding of relative position
            nearest_y = ceil(i / scale_h);
            nearest_x = ceil(j / scale_w);
            output(i, j) = img(nearest_y, nearest_x);
        end
    end
end