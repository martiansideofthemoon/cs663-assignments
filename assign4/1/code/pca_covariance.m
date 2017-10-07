function [signals,PC,V] = pca_covariance(data)

	
	[M,N] = size(data);             %    data - MxN matrix of input data   [M dimensions, N trials]                     
	
	% subtract off the mean for each dimension
	mn =  mean(data,2);
	data = data - repmat(mn,1,N);
	
	% calculate the covariance matrix
	L = 1 / (N-1) * data’ * data  ;


	%PC - each column is a PC and V - Mx1 matrix of variances
	[PC, V] = eig(L);
	% extract diagonal of matrix as vector
	PC = data*PC; 
	
	V = diag(V);
	
	% sort the variances in decreasing order
	[junk, rindices] = sort(-1*V);
	V  = V(rindices);
	PC = PC(:,rindices);
	% project the original data set
	signals = PC’ * data;                         signals - MxN matrix of projected data