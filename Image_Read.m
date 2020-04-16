function [img, file, extension] = Image_Read(filename)

[path, name, extension] = fileparts(filename);

img = strings();
file = strings();

if extension == '.mhd'
    extension;
    
    [img, file] = read_mhd(filename);
    %imshow(img.data(:,:,100),[]) 
    %colorbar;
    %imdisplayrange;
end

if extension == '.dcm'
    extension;
    
    file = dicominfo(filename);
    img = filename;
    %figure;
    %imshow(img,'DisplayRange',[])
    %title('DCM image using GetImage');
    %colorbar;
    %imdisplayrange;
    
end

if extension == '.pgm'
    img = imread(filename);
end

%% Use this for the montage Function
% path  = 'C:\Users\Sagar\OneDrive\Desktop\872\Lab 1\Lab1 - BrainMRI1\';
% 
% voldir = dir([path,'\*.dcm']);
% 
% vol = zeros(256,256,20);
% 
% 
% for i = 1:length(voldir)
%     img = dicomread([path, voldir(i).name]);
%     vol(:,:,i) = img;
% end
% 
% figure
% montage(vol,'DisplayRange',[]);
% colorbar;
% imdisplayrange;









