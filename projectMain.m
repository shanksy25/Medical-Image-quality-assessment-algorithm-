%% Reading in and Converting Image
close all

path1 = 'C:\Users\Adithya\Downloads\Lab1 - LungCT\training_pre19mm.mhd';
[img, info1] = Image_Read(path1);
imgIn = img.data(:,:,230);
imgIn = uint8(255*mat2gray(imgIn));
path2 = 'C:\Users\Adithya\Downloads\Lab1 - LungCT\training_mask.mhd';
[mask, info2] = Image_Read(path2);
maskIn = mask.data(:,:,230);
maskIn = uint8(255*mat2gray(maskIn));

%%%% Original image and mask
% figure;
% imshow(imgIn);
% title('Input image');
% figure;
% imshow(maskIn);
% title('Input mask');

%%%% Gaussian noisy image and original mask
% imgIn = imnoise(imgIn,'gaussian');
% figure;
% imshow(imgIn);
% title('Input image - Gaussian Noise');
% figure;
% imshow(maskIn)
% title('Input mask');

%%%% Salt Pepper noisy image and original mask
imgIn = imnoise(imgIn,'salt & pepper');
figure;
imshow(imgIn);
title('Input image - Salt&Pepper Noise');
figure;
imshow(maskIn)
title('Input mask');

%% NOISE
%SNR = imageNoise(imgIn, maskIn);
 
%% CONTRAST
contrScore = imageContrast(imgIn, maskIn);
 
%% EDGE COMPARISON
%[out, his] = imageEdge(imgIn);
%sharpness = imageEdge(imgIn); %Image Sharpness
