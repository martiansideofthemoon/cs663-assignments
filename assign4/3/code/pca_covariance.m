function [L_eig_vec,signals,A,m] = pca_covariance(X,k)

	m = mean(X,2); %% Computing the average face image m = (1/P)*sum(Xj's')  (j = 1 : P)
	imgcount = size(X,2);
	
	A = [];
	for i=1 : imgcount
	    temp = double(X(:,i)) - m;
	    A = [A temp];
	end

	L= A' * A;
	[V,D] = eig(L);  %% V : eigenvector matrix  D : eigenvalue matrix
    V = A*V;
	D = diag(D);   %extract the diagonal vector
	[~, rindices] = sort(-1*D);
	rindices = rindices(1:k);

	L_eig_vec = [];
    
	for i = rindices 
	    L_eig_vec = [L_eig_vec V(:,i)];
    end
    

	signals = L_eig_vec.'*A;
    
end


