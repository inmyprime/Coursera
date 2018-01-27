clear;close all;
x1=imread('week2.gif');
figure;imshow(x1);
x=double(x1);

filter1=1/9*ones(3,3);
y1=imfilter(x,filter1,'replicate');
figure;imshow(uint8(y1));
mse1=1/(256*256)*sum(sum((x-y1).^2))
psnr1=10*log10(255*255/mse1)

filter2=1/25*ones(5,5);
y2=imfilter(x,filter2,'replicate');
figure;imshow(uint8(y2));
mse2=1/(256*256)*sum(sum((x-y2).^2))
psnr2=10*log10(255*255/mse2)