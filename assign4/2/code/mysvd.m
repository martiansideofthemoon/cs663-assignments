%% functionname: function description
function [signals,eigenfaces,m,A] = mysvd(X,k) 

	m = mean(X,2); %% Computing the average face image m = (1/P)*sum(Xj's')  (j = 1 : P)
	imgcount = size(X,2);
	
	A = [];
	for i=1 : imgcount
	    temp = double(X(:,i)) - m;
	    A = [A temp];
    end
    disp(size(A))
	[U S V] = svd(double(A),'econ');  %%  produces a diagonal matrix S of the same dimension as X, with nonnegative diagonal elements in decreasing order, and unitary matrices U and V 
    eigenfaces = U(:,1:k); %% since U will give me those eigen vectors corresponding to k largest eigen values	
	signals = eigenfaces.'*A;

end