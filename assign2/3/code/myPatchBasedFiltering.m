function output = myPatchBasedFiltering(img,sigmaSpatial,sigmaIntensity)
%sigmaSpatial = sigmaSpatial*1.1; 
%sigmaIntensity = sigmaIntensity*1.1;
img = mat2gray(img); 
input_image = img;
img = imgaussfilt(img,0.66);
img = img(1:3:end , 1:3:end);
corrupted =  img + 0.05*randn(size(img));

in_rows = size(corrupted,1);
in_cols = size(corrupted,2);

windowsize = 25;
patchsize = 9;

w = (windowsize-1) /2; % half windowsize
p = (patchsize-1) /2;  % half patchsize

num = zeros(in_rows,in_cols);
den = zeros(in_rows,in_cols);

spacialDiff = zeros(windowsize, windowsize);
expPatchDiff = zeros(windowsize, windowsize);
window = zeros(windowsize, windowsize);

rangeDifference = zeros(windowsize, windowsize);

for i = 1:in_rows
        if ((i - p)>1)         % ensure that the patch area is within the image boundaries 
        ipMin = i-p;
    else
        ipMin = 1;             % limit patch size in x-direction if it goes beyond image size  
    end;
    if ((i + p)< in_rows)      
        ipMax = i+p;
    else
        ipMax = in_rows;       
    end;
    
    if ((i - w)>1)           % ensure that the window size is within the image boundaries
        iMin = i-w;         
    else
        iMin = 1;           % limit window size x-direction if it goes beyond image size  
    end;
    if ((i + w)< in_rows)   
        iMax = i+w;
    else
        iMax = in_rows;
    end;
    
        for j = 1:in_cols 

        if ((j - p)>1)        % ensure that the patch area is within the image boundaries
            jpMin = j-p;
        else
            jpMin = 1;       % limit patch size y-direction if it goes beyond image size
        end;
        if ((j + p)< in_cols)
            jpMax = j+p;
        else
            jpMax = in_cols;
        end;
        
        if ((j - w)>1)
            jMin = j-w;     % ensure that the patch area is within the image boundaries
        else
            jMin = 1;       % limit window size y-direction if it goes beyond image size
        end;
        if ((j + w)< in_cols)
            jMax = j+w;
        else
            jMax = in_cols;
        end;
        patch2((1:ipMax-ipMin+1),(1:jpMax-jpMin+1)) = corrupted((ipMin:ipMax),(jpMin:jpMax));  % vectorized
 %               for ip2 = ipMin:ipMax
 %                   for jp2 = jpMin:jpMax
 %                     patch2((ip2 - ipMin + 1),(jp2 - jpMin + 1)) = corrupted(ip2, jp2);
 %                   end;
 %               end;
        for i1 = iMin:iMax
            if ((i1 - p)>1)
                i1Min = i1-p;
            else
                i1Min = 1;
            end;
            if ((i1 + p)< in_rows)
                i1Max = i1+p;
            else
                i1Max = in_rows;
            end;
            for j1 = jMin:jMax
                window((i1 - iMin + 1),(j1-jMin+1)) = corrupted(i1, j1);
                spacialDiff((i1-iMin + 1), (j1 - jMin + 1)) = (i - i1)*(i - i1) +(j - j1)*(j-j1);
                if ((j1 - p)>1)
                    j1Min = j1-p;
                else
                    j1Min = 1;
                end;
                if ((j1 + p)< in_cols)
                    j1Max = j1+p;
                else
                    j1Max = in_cols;
                end;
                
                if((i1 - i1Min)<(i - ipMin)) xMin= (i1 - i1Min); else xMin = (i - ipMin); end;
                if((j1 - j1Min)<(j - jpMin)) yMin= (j1 - j1Min); else yMin = (j - jpMin); end;
                if((i1Max - i1)<(ipMax - i)) xMax= (i1Max - i1); else xMax = (ipMax - i); end;
                if((j1Max - j1)<(jpMax - j)) yMax= (j1Max - j1); else yMax = (jpMax - j); end;
                
                patch1 = zeros((i1Max - i1Min + 1),(j1Max - j1Min + 1));
                patch1((1:i1Max-i1Min+1),(1:j1Max-j1Min+1)) = corrupted((i1Min:i1Max),(j1Min:j1Max));
                %for ip = i1Min:i1Max
                %    for jp = j1Min:j1Max
                %        patch1((ip - i1Min + 1),(jp - j1Min + 1)) = corrupted(ip, jp);
                %    end;
                %end;
                patchDiff = 0;
                for x = 1:(xMin+xMax+1)
                    for y = 1:(yMin+yMax+1)
                        patchDiff =patchDiff + (((patch1(x,y) - patch2(x,y))*(patch1(x,y) - patch2(x,y)))/(sigmaIntensity*sigmaIntensity));
                    end;
                end;
                expPatchDiff((i1 - iMin + 1),(j1 - jMin + 1)) = exp(patchDiff*(-1));
            end;
        end;
        % p pixel is at location i,j
        
        gsSpacial = exp((spacialDiff*(-0.5))/(sigmaSpatial*sigmaSpatial)); %Cg matrix
        % expPatchDiff is Cs matrix
        t = gsSpacial.*expPatchDiff;
        num(i,j) = sum(sum(window.*t));
        den(i,j) = sum(sum(t));
    end;

end;
output = num./den;
save('output', 'output')

rmsd = sqrt((1/(in_rows*in_cols))*(sum(sum((img-output)*(img-output)))));
rmsd
sigmaSpatial
sigmaIntensity

figure(1);
subplot(1,3,1), imshow(input_image, 'InitialMagnification', 'fit'),title('input image')
subplot(1,3,2), imshow(corrupted, 'InitialMagnification', 'fit'),title('corrupted image')
subplot(1,3,3), imshow(output, 'InitialMagnification', 'fit'),title('output image')
axis on,colorbar, waitforbuttonpress

figure(2); 
imshow(num, 'InitialMagnification', 'fit'),title('mask')


end