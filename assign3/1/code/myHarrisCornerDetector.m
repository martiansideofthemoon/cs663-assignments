function output = myHarrisCornerDetector(img)
	img = mat2gray(img);
    img = imgaussfilt(img,0.6);
	img = myLinearContrastStretching(img,1.0);
	%copy_img = img.copy();

	width = size(img,1);
	height = size(img,2);

	sigma = 0.6;

	dx = [-1 0 1; -2 0 2; -1 0 1];	 % vertical derivative mask 
	dy = [-1 -2 -1; 0 0 0; 1 2 1];	 % horizontal derivative mask 

	Ix = conv2(img,dx);							
	Iy = conv2(img,dy);
    Ix = imgaussfilt(Ix,sigma);
    Iy = imgaussfilt(Iy,sigma);
    
	Ix2 = Ix.* Ix;                          % get Ix to the power of two 
	Iy2 = Iy.* Iy;                          % get Iy to the power of two
	Ixy = Ix .* Iy;                         %get the Ixy by multiply Ix and Iy


	window_size = 4 ;
	offset = window_size/2;
	threshold = 0; 
	k = 0.05; 
    
    for x=offset:width-offset,
   		for y=offset:height-offset 
   			windowIx2 = Ix2(x-offset+1:x+offset,y-offset+1:y+offset);
            windowIy2 = Iy2(x-offset+1:x+offset, y-offset+1:y+offset );
            windowIxy = Ixy(x-offset+1:x+offset, y-offset+1:y+offset);
            window = img(x-offset+1:x+offset,y-offset+1:y+offset)
%             window = imgaussfilt(window,0.8);
            
            windowIx2 = window.*windowIx2;
            windowIy2 = window.*windowIy2;
            windowIxy = window.*windowIxy;
            
            Sxx = sum(sum(windowIx2)); 
            Syy = sum(sum(windowIy2));
            Sxy = sum(sum(windowIxy));

            M = [ Sxx Sxy ; Sxy Syy ];
            
            e = eig(M);
            eigen1(x,y) = e(1);
            eigen2(x,y) = e(2); 
            
            R = det(M) - k*(trace(M)^2);
            score(x,y) = R;
            
            if R > threshold
                output = insertShape(img,'circle',[x y 35],'LineWidth',5);    
            end
        end
    end    
        
eigen1 = myLinearContrastStretching(eigen1,1.0);
eigen2 = myLinearContrastStretching(eigen2,1.0);
score = myLinearContrastStretching(score,1.0);

figure,
subplot(2,1,1) , imshow(Ix, 'InitialMagnification', 'fit'), title('derivative along X'),
axis on,colorbar
subplot(2,1,2), imshow(Iy, 'InitialMagnification', 'fit'),title('derivative along Y')
axis on,colorbar, waitforbuttonpress

subplot(2,1,1) , imshow(eigen1, 'InitialMagnification', 'fit'), title('eigen1'),
axis on,colorbar
subplot(2,1,2), imshow(eigen2, 'InitialMagnification', 'fit'),title('eigen2')
axis on,colorbar, waitforbuttonpress

imshow(score, 'InitialMagnification', 'fit'),title('corner-ness')
axis on,colorbar, waitforbuttonpress

figure,
imshow(output, 'InitialMagnification', 'fit'),title('output')
axis on,colorbar

  end
