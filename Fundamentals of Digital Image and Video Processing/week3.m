clear;close all;
x=imread('week3.jpg');
figure;imshow(x);
x1=double(x);

lpf=1/9*ones(3,3);
x2=imfilter(x1,lpf,'replicate');
figure;imshow(uint8(x2));

x3=x2;
x3(2:2:end,:)=[];
x3(:,2:2:end)=[];
figure;imshow(uint8(x2));

x4=x2;
x4(2:2:end,:)=0;
x4(:,2:2:end)=0;
figure;imshow(uint8(x4));

filter=[0.25,0.5,0.25;0.5,1,0.5;0.25,0.5,0.25];
x5=imfilter(x4,filter);
figure;imshow(uint8(x5));

mse=1/(479*359)*sum(sum((x5-x1).^2))
psnr=10*log10(255*255/mse)
