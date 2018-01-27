clear all
close all

%% Simulate 1-D blur and noise
image_original = im2double(imread('Cameraman256.bmp', 'bmp'));
[H, W] = size(image_original);
blur_impulse = fspecial('motion', 7, 0);
image_blurred = imfilter(image_original, blur_impulse, 'conv', 'circular');
noise_power = 1e-4;
randn('seed', 1);
noise = sqrt(noise_power) * randn(H, W);
image_noisy = image_blurred + noise;

figure; imshow(image_original);
figure; imshow(image_blurred);
figure; imshow(image_noisy);

%% CLS restoration
alphaVec = [0.0001,0.001,0.01,0.1,1,10,100];
for i = 1:length(alphaVec)
    alpha = alphaVec(i);  % you should try different values of alpha
    image_cls_restored = cls_restoration(image_noisy, blur_impulse, alpha);
    figure; imshow(image_cls_restored);
    
    %% computation of ISNR
    ISNR = 10 * log10(sum(sum((image_original - image_noisy).^2))/sum(sum((image_original - image_cls_restored).^2)));
    disp(alpha);
    disp(ISNR)
end