im_noisy = double(imread('week5_noisy.jpg'));
figure;imshow(uint8(im_noisy));
f1 = medfilt2(im_noisy);
figure;imshow(uint8(f1));
f2 = medfilt2(f1);
figure;imshow(uint8(f2));

im_original = double(imread('week5_original.jpg'));
[m,n] = size(im_noisy)
mse1=1/(m*n)*sum(sum((im_original-im_noisy).^2));
psnr1=10*log10(255*255/mse1)
mse2=1/(m*n)*sum(sum((im_original-f1).^2));
psnr2=10*log10(255*255/mse2)
mse3=1/(m*n)*sum(sum((im_original-f2).^2));
psnr3=10*log10(255*255/mse3)