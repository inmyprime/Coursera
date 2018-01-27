# 3
b1 = [2,2,5,6; 2,2,3,4; 1,1,2,2; 1,1,2,2];
b2 = [2,2,5,3; 2,2,6,4; 2,2,2,2; 2,2,1,1];
mse = sum(sum((b2-b1).^2))/16

# 4
b1 = [50,60,20,20; 30,40,20,20; 20,40,10,10; 10,20,10,10];
b21 = [20,20,50,60; 20,20,30,40; 20,40,10,10; 10,20,10,10];
b22 = [60,70,30,30; 40,50,30,30; 30,50,20,20; 20,30,20,20];
b23 = [10,10,20,20; 10,10,20,20; 20,40,50,60; 10,20,30,40];
b24 = [5,6,2,2; 3,4,2,2; 2,4,1,1; 1,2,1,1];

mae1 =  sum(sum(abs(b1-b21)))/(4*4)  % 12.5
mae2 =  sum(sum(abs(b1-b22)))/(4*4)  % 10
mae3 =  sum(sum(abs(b1-b23)))/(4*4)  % 17.5
mae4 =  sum(sum(abs(b1-b24)))/(4*4)  % 21.938

# 8
clear;close all;
i1 = double(imread('frame_1.jpg'));
i2 = double(imread('frame_2.jpg'));

bt = i2(65:96,81:112);
[m,n] = size(bt);  % 32 x 32
[im,in] = size(i1);  % 288 x 352

minMAE = Inf;
minI = 1;
minJ = 1;
for i = 1:im-m
  for j = 1:in-n
    b1 = i1(i:i+31,j:j+31);
    mae = sum(sum(abs(bt-b1)))/(32*32);
    if mae < minMAE
      minMAE = mae;
      minI = i;
      minJ = j;
    end
  end
end

display(minI+minJ);
display(minMAE);