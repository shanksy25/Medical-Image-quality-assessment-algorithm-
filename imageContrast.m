function contrMetric = imageContrast(ROI, mask)
    mask = mask/255;
    
    ROI = immultiply(ROI, mask);
    
%     ROIdb = im2double(ROI);   
%     rmin = min(min(ROIdb));
%     rmax = max(max(ROIdb));
%     imgnew = 255*(((1/(rmax-rmin))* ROIdb) - (rmin/(rmax-rmin)));
%     ROI2 = uint8(imgnew); %contrast stretched roi
    ROI2 = histeq(ROI); %contrast stretched roi

    figure;
    subplot(2,1,1)
    histogram(ROI,'BinLimits', [10,200]);
    title('ROI');
    xlabel("Intensity");
    ylabel("Number of Occurences");
    subplot(2,1,2)
    histogram(ROI2,'BinLimits', [230,255]);  
    xlabel("Intensity");
    ylabel("Number of Occurences");
    title('Contrast stretched ROI');

    [counts1,locations1] = imhist(ROI); %histogram for roi
    [counts2,locations2] = imhist(ROI2); %histogram for contrast tretched roi
    
    
    counts1 = counts1(2:256); %remove bin count from cell (1,1) in both arrays
    counts2 = counts2(2:256);
    
    %add 1 to each cell value to remove dividing by 0
    count1 = counts1 + 1;
    count2 = counts2 + 1;
    
    %binmax = max(max(count1, count2));

    calc = 0;
    for i = 1:255
        ratio = (count1(i)/count2(i)); %ratio between bin volumes from each image
        calc = calc + (ratio/255); %summation and append to array
    end

    contrMetric = calc;
   
end

