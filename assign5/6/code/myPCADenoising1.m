function output = myPCADenoising1(img, sigma)
    [rows, cols] = size(img);
    dim = 7;

    % extracting the patches
    patches = zeros([dim*dim, (rows-dim+1) * (cols-dim+1)]);
    counter = 1;
    for i=1:rows-dim+1
        for j=1:cols-dim+1
            patch = img(i:i+dim-1, j:j+dim-1);
            patches(:, counter) = patch(:);
            counter = counter + 1;
        end
    end

    % Computing the eigen vectors
    p2 = patches * patches';
    [V, D] = eig(p2);

    % Computing the eigen coefficients
    counter = 1;
    eig_coeff = zeros([dim*dim, (rows-dim+1) * (cols-dim+1)]);
    for i=1:rows-dim+1
        for j=1:cols-dim+1
            patch = img(i:i+dim-1, j:j+dim-1);
            eig_coeff(:, counter) = V' * patch(:);
            counter = counter + 1;
        end
    end

    % Computing \alpha_j^2
    eig_sq = max(0, mean(eig_coeff .^ 2, 2) - (sigma * sigma));
    % Estimating correct coefficients
    eig_coeff_denoised = eig_coeff;
    for i=1:(dim*dim)
        eig_coeff_denoised(i, :) = eig_coeff(i, :) / (1 + (sigma * sigma / eig_sq(i)));
    end

    % Reconstruct original patches and image
    counter = 1;
    output = zeros(size(img));
    output_counter = zeros(size(img));
    patches_denoised = patches;
    for i=1:rows-dim+1
        for j=1:cols-dim+1
            patch_denoised = V * eig_coeff_denoised(:, counter);
            patch_denoised = reshape(patch_denoised, [dim, dim]);
            output(i:i+dim-1, j:j+dim-1) = output(i:i+dim-1, j:j+dim-1) + patch_denoised;
            output_counter(i:i+dim-1, j:j+dim-1) = output_counter(i:i+dim-1, j:j+dim-1) + 1;
            counter = counter + 1;
        end
    end
    output = output ./ output_counter;
end