function [Ix, Iy, eigen1, eigen2, score, output] = myHarrisCornerDetector(img, k, sigma, sigma_window, threshold)

    width = size(img,1);
    height = size(img,2);


    dx = [-1 0 1; -2 0 2; -1 0 1];	 % vertical derivative mask
    dy = [-1 -2 -1; 0 0 0; 1 2 1];	 % horizontal derivative mask

    Ix = conv2(img,dx);
    Iy = conv2(img,dy);
    Ix = imgaussfilt(Ix, sigma);
    Iy = imgaussfilt(Iy, sigma);

    Ix2 = Ix .* Ix;                          % get Ix to the power of two
    Iy2 = Iy.* Iy;                          % get Iy to the power of two
    Ixy = Ix .* Iy;                         %get the Ixy by multiply Ix and Iy


    window_size = 4;
    offset = window_size / 2;

    output = zeros(height, width, 3);
    for i=1:3
        output(:, :, i) = img;
    end

    for x = offset:width - offset,
        for y = offset:height - offset
            windowIx2 = Ix2(x-offset+1:x+offset,y-offset+1:y+offset);
            windowIy2 = Iy2(x-offset+1:x+offset, y-offset+1:y+offset );
            windowIxy = Ixy(x-offset+1:x+offset, y-offset+1:y+offset);
            window = img(x-offset+1:x+offset,y-offset+1:y+offset);
            % window = imgaussfilt(window, sigma_window);

            windowIx2 = window .* windowIx2;
            windowIy2 = window .* windowIy2;
            windowIxy = window .* windowIxy;

            Sxx = sum(sum(windowIx2));
            Syy = sum(sum(windowIy2));
            Sxy = sum(sum(windowIxy));
            M = [ Sxx Sxy ; Sxy Syy ];
            e = eig(M);
            eigen1(x, y) = e(1);
            eigen2(x, y) = e(2);

            R = det(M) - k*(trace(M)^2);
            score(x,y) = R;

            if R > threshold
                output(x, y, 1) = 0.0;
                output(x, y, 2) = 1.0;
                output(x, y, 3) = 0.0;
            end
        end
    end
end
