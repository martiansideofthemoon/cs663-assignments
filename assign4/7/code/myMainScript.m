%% MyMainScript

tic;
PC = [1,2,3,5,10,15,20,30,50,75,100,150,170];
Rrate = [];

for k = [1,2,3,5,10,15,20,30,50,75,100,150,170]	

	%% Training 
    cd ../..
	cd att_faces
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
	cd '7/code/' 

 	[signals,eigenfaces,m,A] = mysvd(X,k);  %% function for projecting the images on the k largest eigenvectors--using SVD

	%% testing
	cd ../..
	cd att_faces
	euclide_dist_min = [];
	count = 0;
    for i = 1:32
		folder_name = strcat('s',num2str(i));
		cd(folder_name)
		for j=7:10
			filename = strcat(num2str(j),'.pgm');
			test_image = imread(filename);
			[r c] = size(test_image);
			temp = reshape(test_image',r*c,1); 
			temp = double(temp)-m; 
			projtestimg = eigenfaces'*temp; % projection of test image onto the facespace
		
			euclide_dist = [ ];
			for l=1 : size(eigenfaces,2)
			    temp = (norm(projtestimg-signals(:,l)))^2;
			    euclide_dist = [euclide_dist temp];
            end
            [temp recognized_index] = min(euclide_dist);
			euclide_dist_min = [euclide_dist_min temp]; 
            recognized_index;
            subject = 0;
            if mod(recognized_index,6) == 0 
                subject =  fix(recognized_index/6);
            else
                subject =  fix(recognized_index/6);
            end
			if subject == i
				count = count + 1;                            
			end 	
			no = mod( recognized_index , 6 );                                           %index of the face of a particular subject
			recognized_img = strcat('s',int2str(subject),'_',int2str(no),'.pgm');	
        end
        cd ..
    end
    cd ../7/code/
	Rrate = [Rrate count/128];
end

plot(PC,Rrate)	

toc;
