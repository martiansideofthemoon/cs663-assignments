%% MyMainScript

tic;
PC = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
Rrate = [];
Rrate_3 = [];
datasetPath = 'CroppedYale';
for k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000]	
    
	%% Training 
    cd ../..
	folders = dir(datasetPath);
	folders = {folders.name};
    folders = folders(3:end); 
	cd(datasetPath);
	X = [];
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
            temp = reshape(img',r*c,1); %%reshaping the matrix
			X = [X temp]; %% matrix of image column vectors
		end
		cd ..
    end
    size(X)
	cd ..  % coming out of att_faces 
	cd '1/code/' 
	[signals,eigenfaces,m,A] = mysvd(X,k);  %% function for projecting the images on the k largest eigenvectors--using SVD

	%% testing
	cd ../..
	folders = dir(datasetPath);
	folders = {folders.name}; 
	folders = folders(3:end);
    cd(datasetPath);
	euclide_dist_min = [];
	count = 0;
	count_3 = 0; 
    for i = folders
		i = char(i);
        files = dir(i);
		files = {files.name};
		files = files(45:64);
        cd(i)
		for j=files
            j = char(j);
			test_image = imread(j);
			[r c] = size(test_image);
			temp = reshape(test_image',r*c,1); 
			temp = double(temp)-m; 
			projtestimg = L_eig_vec.'*temp; % projection of test image onto the facespace
			
			euclide_dist = [ ];
			for l=1 : size(signals,2)
			    temp = (norm(projtestimg-signals(:,l)))^2;
			    euclide_dist = [euclide_dist temp];
            end
            [temp recognized_index] = min(euclide_dist);
			euclide_dist_min = [euclide_dist_min temp]; 
            subject = ceil(recognized_index/6);
            if subject == i
            	count = count + 1; 
			end

			euclide_dist = [ ];
			for l=4 : size(signals,2)					%top 3 eigen coefficients 
			    temp = (norm(projtestimg-signals(:,l)))^2;
			    euclide_dist = [euclide_dist temp];
            end
            [temp recognized_index] = min(euclide_dist);
			euclide_dist_min = [euclide_dist_min temp]; 
            subject = ceil(recognized_index/6);
            if subject == i
            	count_3 = count_3 + 1; 
			end

        end
        cd ..
    end
    cd ../1/code/
	Rrate = [Rrate count*100/128];
	Rrate_3 = [Rrate_3 count_3*100/128];	
end

ax1 = subplot(2,1,1);
plot(ax1,PC,Rrate)
title(ax1,'all eigenvectors')
plot(PC,Rrate)	

ax2 = subplot(2,1,2);
plot(ax2,PC,Rrate_3)
title(ax2,'all except top 3 eigenvectors')
plot(PC,Rrate)

toc;
