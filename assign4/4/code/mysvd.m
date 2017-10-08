%% functionname: function description
function [signals,eigenfaces,m,A] = mysvd(X) 

	m = mean(X,2); %% Computing the average face image m = (1/P)*sum(Xj's')  (j = 1 : P)
	imgcount = size(X,2);
	
	A = [];
	for i=1 : imgcount
	    temp = double(X(:,i)) - m;
	    A = [A temp];
	end

	[U S V] = svd(X); %%  produces a diagonal matrix S of the same dimension as X, with nonnegative diagonal elements in decreasing order, and unitary matrices U and V 
	L_eig_vec = U(:,1:k); %% since U will give me those eigen vectors corresponding to k largest eigen values
	eigenfaces = A * L_eig_vec;

	signals = [];
	for i = 1 : size(eigenfaces,2)
		temp = eigenfaces' * A(:,i);
		signals = [signals temp];
	end

end