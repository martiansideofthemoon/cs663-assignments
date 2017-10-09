%% MyMainScript

tic;
PC = [1,2,3,5,10,15,20,30,50,75,100,150,170];
Rrate = [];
euclide_dist_min1 = []; %% vector of minimum distances of trained images
euclide_dist_min2 = []; %% vector of minimum distances of untrained images
correctly_matched = []; %% vector of correctly matched images of trained set

datasetPath = 'att_faces';
k = 100	;%% number of eigen faces
    
%% Training 
cd ../..
cd(datasetPath);
X = [];
for i = 1:32
	folder_name = strcat('s',num2str(i));
	cd(folder_name);

	for j = 1:6
		filename = strcat(num2str(j),'.pgm');
		img = imread(filename);
		[r c] = size(img);
		temp = reshape(img',r*c,1); %%reshaping the matrix
		X = [X temp]; %% matrix of image column vectors
	end
	cd ..
end

cd ..  % coming out of att_faces 
cd '3/code/' 
[L_eig_vec, signals,A,m] = pca_covariance(X,k); %% function for projecting the images on the k largest eigenvectors

%% testing -- TRAINED IMAGES 
cd ../..
cd(datasetPath);

for i = 1:32
	folder_name = strcat('s',num2str(i));
	cd(folder_name)
	for j=7:10
		filename = strcat(num2str(j),'.pgm');
		test_image = imread(filename);
		[r c] = size(test_image);
		temp = reshape(test_image',r*c,1); 
		temp = double(temp)-m; 
		projtestimg = L_eig_vec.'*temp; % projection of test image onto the facespace
	
		euclide_dist = [ ];
		for l=1 : size(signals,2)
		    temp = (norm(projtestimg-signals(:,l)))^2; %%calculating mean square distance
		    euclide_dist = [euclide_dist temp];
        end
        [temp recognized_index] = min(euclide_dist);
		euclide_dist_min1 = [euclide_dist_min1 temp]; %% vector of minimum msd for each image from the database
        
        subject = ceil(recognized_index/6);
        
        if subject == i
        	correctly_matched = [correctly_matched temp]; %% vector of correctly matched images 
		end
    end
    cd ..
end

cd ../3/code/

Rrate = [Rrate count/128];
correctly_matched = sort(correctly_matched);
index = ceil(0.8*size(correctly_matched,2));
treshold = correctly_matched(index);

%% testing -- UNTRAINED IMAGES 
cd ../..
cd(datasetPath);


for i = 33:40
	folder_name = strcat('s',num2str(i));
	cd(folder_name)
	for j=1:4
		filename = strcat(num2str(j),'.pgm');
		test_image = imread(filename);
		[r c] = size(test_image);
		temp = reshape(test_image',r*c,1); 
		temp = double(temp)-m; 
		projtestimg = L_eig_vec.'*temp; % projection of test image onto the facespace
	
		euclide_dist = [ ];
		for l=1 : size(signals,2)
		    temp = (norm(projtestimg-signals(:,l)))^2; %%calculating mean square distance
		    euclide_dist = [euclide_dist temp];
        end
        [temp recognized_index] = min(euclide_dist);
		euclide_dist_min2 = [euclide_dist_min2 temp]; %% vector of minimum msd for each image from the database

    end
    cd ..
end
cd ../3/code/

count = 0;
for i = 1:32
	if(euclide_dist_min2(i) > treshold)
        count = count +1;
	end
end

false_positive_ratio = (32-count)/32.0

% figure
% subplot(2,1,1)       % add first plot in 2 x 1 grid
% histogram(correctly_matched);
% title('Subplot 1')
% 
% subplot(2,1,2)       % add first plot in 2 x 1 grid
% histogram(euclide_dist_min2);
% title('Subplot 2')

toc;