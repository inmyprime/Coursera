clc;clear;

D = zeros(10,10);
for i = 1:10
  for j = 1:10
    D(i,j) = sin(i+j);
  end
end
I = eye(10,10);
A = D + I;
b = [-2,-6,-9,1,8,10,1,-9,-4,-3]';
S = 3;

A = normc(A);
x = zeros(10,1);
r = b;
Omega = [];

while sum(x~=0) < S
  max_xj = -1;
  i = 0;
  for j = 1:10
    if any(Omega == j)
      continue
    end
    xj = A(:,j)'*r;
    if abs(xj) > max_xj
      max_xj = abs(xj);
      i = j;
    end
  end
  Omega = [Omega i];
  A_omega = A(:,Omega);
  x = A_omega \ b;
  r = b - A_omega * x;
end

disp(['Omega = ', num2str(Omega)])
disp(sum(Omega))
disp(x)
disp(A_omega * x)
