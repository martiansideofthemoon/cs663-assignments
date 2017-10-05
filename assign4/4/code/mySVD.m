function [U, V, S] = mySVD(A)
    [m, n] = size(A);
    A_A_t = A * A';
    A_t_A = A' * A;
    [U, D1] = eig(A_A_t);
    [D1, ord] = sort(diag(D1), 'descend');
    S = sqrt(D1);
    U = U(:, ord);

    [V, D2] = eig(A_t_A);
    [D2, ord] = sort(diag(D2), 'descend');
    V = V(:, ord);

    tolerance = 1e-8;
    for i=1:min(m, n)
        lhs = A * V(:, i);
        rhs = S(i) * U(:, i);
        if norm(lhs - rhs) > tolerance
            V(:, i) = -1 * V(:, i);
        end
    end
end