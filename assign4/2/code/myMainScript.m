subject_indices = dir('../../CroppedYale/*yale*');
X = [];

for i=1:38
    img_indices = dir(strcat('../../CroppedYale/', subject_indices(i).name,'/*yale*'));
    for j=1:60
        image_path = strcat('../../CroppedYale/', subject_indices(i).name, '/' , img_indices(j).name);
        I = imread(image_path);
        [r, c] = size(I);
        I = I(:);
        X = [X I];
    end
end

[m, n] = size(X);
m = uint8(sum(X, 2)/n);
X = X - repmat(m, [1, n]);
X = double(X);

top_comp = [2 10 20 50 75 100 125 150 175];

figure
count = 1;
for j = top_comp
    [E, ~, ~] = svds(X.', j);
    E = E(:,1:j);

    V = X*W;
    V = normc(V);

    C = V;
    eigen_coeffs_training = C.'*X;
    
    eigen_coeffs_1 = eigen_coeffs_training(:,1);
    face = C*eigen_coeffs_1;
    face = reshape(face, [r, c]);
    K = mat2gray(face);
    subplot(3, 3, count); imshow(K);
    count = count + 1; 
end

figure
[E, ~, ~] = svds(X.', 25);
E = E(:,1:25);
V = X*E;
V = normc(V);

for j=1:25
    eigenface = V(:,j);
    eigenface = reshape(eigenface, [r, c]);
    K = mat2gray(eigenface);
    subplot(5, 5, j); imshow(K);
end
