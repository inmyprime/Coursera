close all;clear;clc;
I = imread('Cameraman256.bmp');
idouble = im2double(I);
imshow(idouble);
e = entropy(idouble);
display(e)

prob = zeros(1,256);
imArray = I(:);
for i = 1:length(imArray)
  prob(imArray(i)+1) = prob(imArray(i)+1) + 1;
end

prob = prob/length(imArray);
en = 0;
for i = 1:256
  if prob(i) != 0
    en = en + prob(i)*log2(1/prob(i));
  end
end

disp(en)
    