function Edg = imageEdge(img)
    imgread = double(img);
    
    if (size(imgread,3) > 1) % Normalize image
        [x, y, z] = size(imgread);
        img_p = zeros(x,y,z);
        imgNorm = zeros(x,y,z);
        for k = 1:z
            slice = imgread(:,:,k);
            a = min(slice(:));
            img_p(:,:,k) = abs(a) + slice;
            b = img_p(:,:,k);
            maxImg = max(b(:));
            if (a ~= b)
                imgNorm(:,:,k) = b./maxImg;
            end
        end
    else
        slice = imgread;
        a = min(slice(:));
        img_p = abs(a) + slice;
        b = img_p;
        maxImg = max(b(:));
        imgNorm = b./maxImg;
    end
    
    % FM algorithm to calculate image sharpness
    if (size(imgread,3) > 1)
        [x, y, z] = size(imgNorm);
        Edg = zeros(1,z);
        for k = 1:z
            slice = imgNorm(:,:,k);
            F = fft2(slice); %Frequency spectrum
           
            fftShift = fftshift(F); %Shift frequency spectrum
            fftMag = abs(fftShift); %Frequency magnitude
            fftLog = log(1 + fftMag); %Log version of the magnitude for plotting  
            
            m = max(fftMag(:)); %Compute max values in frequency magnitude
            thres = m/1000; %Compute threshold
            T = 0; %Compute total number of pixels with intensity > threshold
            [x, y] = size(F);
            for i = 1:x
                for j = 1:y
                    pixel = F(i,j);
                    if (pixel > thres)
                        T = T + 1;
                    end
                end
            end

            [m, n] = size(slice); 
            Edg(k) = T/(m*n); %image sharpness
        end
        
        Edg = sum(Edg)/z;
        
    else
        slice = imgNorm;
        F = fft2(slice);
        fftShift = fftshift(F);
        fftMag = abs(fftShift);
        fftLog = log(1+fftMag);    
        
        m = max(fftMag(:));
        thres = m/1000;
        
        T = 0;
        [x, y] = size(F);
        for i = 1:x
            for j = 1:y
                pixel = F(i, j);
                if (pixel > thres)
                    T = T + 1;
                end
            end
        end

        [m, n] = size(imgNorm); 
        Edg = T/(m*n);
        
        figure;
        imshow(fftLog,[]);
        title('Frequency Magnitude of Image');
        colorbar;
    end
    
end