%% MyMainScript

tic;
PC = [1,2,3,5,10,15,20,30,50,75,100,150,170];
Rrate = [];
datasetPath = 'CroppedYale';
for k = [1,2,3,5,10,15,20,30,50,75,100,150,170]	
    
	%% Training 
    cd ../..	
	folders = dir(datasetPath);
	folders = {folders.name};
    folders = folders(3:end); 
	cd(datasetPath);
	X = [];
	height = 0;
	width = 0;
	for i = folders
		i = char(i);
        files = dir(i);
		files = {files.name};
		files = files(3:44);
        cd(i);
        length(files)
		for j = files;
			j = char(j);
            img = imread(j);
			
            [r c] = size(img);
            width = r ;
            height = c;
            temp = reshape(img',r*c,1); %%reshaping the matrix
			X = [X temp]; %% matrix of image column vectors
		end
		cd ..
    end
    size(X)
	cd ..  % coming out of att_faces 
	cd '1/code/' 
	[signals,eigenfaces,m,A] = mysvd(X,k);  %% function for projecting the images on the k largest eigenvectors--using SVD

	%% Reconstruction

	pcaRecon = (eigenfaces * signals') + m;
	pcaRecon = uint8(pcaRecon);
	figure, imshow(pcaRecon), title('PCA Recognition');
	waitforbuttonpress

	%% display the eigenvectors
	figure;
	for n = 1:25
	    subplot(2, ceil(25/2), n);
	    evec = reshape(eigenfaces(:,n), [width height]);
	    imshow(evector);
	end

end



toc;
