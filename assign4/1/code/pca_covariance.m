function [eigenfaces,signals,A,m] = pca_covariance(X,k)

	m = mean(X,2); %% Computing the average face image m = (1/P)*sum(Xj's')  (j = 1 : P)
	imgcount = size(X,2);
	
	A = [];
	for i=1 : imgcount
	    temp = double(X(:,i)) - m;
	    A = [A temp];
	end

	L= A' * A;
	[V,D] = eig(L);  %% V : eigenvector matrix  D : eigenvalue matrix

	D = diag(D);   %extract the diagonal vector
	[B, rindices] = sort(-1*D);
	rindices = rindices(1:k);

	L_eig_vec = [];

	for i = rindices 
	    L_eig_vec = [L_eig_vec V(:,i)];
	end

	eigenfaces = A * L_eig_vec;
    signals = [];
	for i = 1 : size(eigenfaces,2)
       
	    temp = eigenfaces' * A(:,i);
	    signals = [signals temp];
	end
end


