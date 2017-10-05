%% MyMainScript

tic;
m = 5;
n = 7;
A = reshape(randperm(m * n), m, n);
% Generating SVD
[U, V, S] = mySVD(A);

% Converting the vector into m*n form
diag_S = diag(S);
if n > m
    diag_S = cat(2, diag_S, zeros(m, n-m));
elseif m > n
    diag_S = diag_S(:, 1:n);
end
% Comparing values of A with U*S*V^T
A
U * diag_S * V'
toc

