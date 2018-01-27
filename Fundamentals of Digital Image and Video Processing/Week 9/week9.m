close all;clear;clc;
I = imread('Cameraman256.bmp');
imDouble = im2double(I);
figure;imshow(imDouble)
imwrite(imDouble,'Compressed.jpg','jpg','quality',10);

im_original = double(I);
[m,n] = size(im_original);
figure;im_compressed = double(imread('Compressed.jpg'));
imshow(uint8(im_compressed));

mse=1/(m*n)*sum(sum((im_original-im_compressed).^2));
psnr=10*log10(255*255/mse);
disp(psnr);