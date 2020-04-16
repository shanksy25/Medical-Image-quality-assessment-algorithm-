function SNR = imageNoise(img, mask)
    %% Preprocess image intensity ranges
    formatImg = double(255 * (mat2gray(img)));
    formatMask = double(mat2gray(mask));
    
    %% Display Images with Histograms
    [bins, freq] = IntensityHistogram(formatImg);
    
    figure;
    bar(bins, freq);
    title("Image Histogram");
    xlabel("Intensity");
    ylabel("Number of Occurences");

    %% Obtain image size
    [x, y] = size(formatImg);
    
    %% Average intensity of ROI
    sum = 0;
    xlung = 0;
    ylung = 0;
    
    for i = 1:x
        for j = 1:y
            if formatMask(i, j)==1
                sum = sum + formatImg(i, j);
                xlung = xlung + 1;
                ylung = ylung + 1;
            end
        end
    end
    
    avgLungIntens = sum/xlung;
    
    %% Standard deviation/noise in image background
    var = 0;
    xbckgrnd = 0;
    ybckgrnd = 0;
    for i = 1:x
        for j = 1:y
            if formatMask(i,j)== 0
                xbckgrnd = xbckgrnd + 1;
                ybckgrnd = ybckgrnd + 1;
                var = var + (formatImg(i, j) - avgLungIntens)^2;
            end
        end
    end
    
    variance = var/xbckgrnd;
    sd = sqrt(variance);
    
    SNR = avgLungIntens/sd;
end