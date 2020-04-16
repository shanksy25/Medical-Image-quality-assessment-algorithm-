function [bins, freq] = IntensityHistogram(Original_Image)

    Total_Bins = 256;
    Bin_Ceiling = max(Original_Image, [], 'all');
    Bin_Floor = min(Original_Image, [], 'all');

    Bin_Span = Bin_Ceiling-Bin_Floor;
    Bin_Length = ceil((Bin_Span+1)/Total_Bins);

    bins = zeros([Total_Bins Bin_Length]);
    freq = zeros([1 Total_Bins]);

    for i = 1:Total_Bins-1
        bins(i,:)=(Bin_Floor+(i-1)*Bin_Length:Bin_Floor+i*Bin_Length-1);
    end

    bins(Total_Bins,1:length(Bin_Floor+(Total_Bins-1)*Bin_Length:Bin_Ceiling))=(Bin_Floor+(Total_Bins-1)*Bin_Length:Bin_Ceiling);
    bins(Total_Bins,length(Bin_Floor+(Total_Bins-1)*Bin_Length:Bin_Ceiling)+1:end)=sqrt(-1);

    for n = 1:Total_Bins
        for m = 1:length(bins(n,:))
                freq(n)=freq(n)+sum(Original_Image(:,:)==bins(n,m),'all');
        end
    end

    for i = 1:256
        if freq(i) > 20000
           freq(i) = 0;
        end

    end

end