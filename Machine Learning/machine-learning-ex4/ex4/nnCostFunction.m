function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

X = [ones(m, 1) X];
z2 = Theta1*X';
a2 = sigmoid(z2)';
a2 = [ones(m, 1) a2];
z3 = Theta2*a2';
h = sigmoid(z3);

Y = zeros(num_labels, m);
for i = 1:m
  Y(y(i),i) = 1;
end

% Sum the deviance between h(x) and y in each output unit
% and then average this difference among all x
J = 1/m*sum(sum((-Y.*log(h)-(1-Y).*log(1-h))));

% Regularized cost function
J = J + lambda/(2*m)*(sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));

%for t = 1:m
%  % step 1
%  xt = X(t,:)';
%  yt = Y(:,t);
%  
%  a_1 = xt;
%  z_2 = Theta1 * xt;
%  a_2 = [1; sigmoid(z_2)];
%  z_3 = Theta2*a_2;
%  a_3 = sigmoid(z_3);
%  
%  % step 2
%  delta_3 = a_3 - yt;
%  
%  % step 3
%  delta_2 = Theta2' * delta_3 .* sigmoidGradient([0;z_2]);
%  
%  % step 4
%  delta_2 = delta_2(2:end);
%  Theta1_grad = Theta1_grad + delta_2 * a_1';
%  Theta2_grad = Theta2_grad + delta_3 * a_2';
%end

delta_3 = h - Y;
delta_2 = Theta2' * delta_3 .* sigmoidGradient([zeros(1,m);z2]);
delta_2 = delta_2(2:end, :);

% sum(ai*bi) is equivalent to inner_product(a,b)
Theta1_grad = delta_2 * X;
Theta2_grad = delta_3 * a2;

% step 5
Theta1_grad = Theta1_grad/m + lambda/m*[zeros(hidden_layer_size,1) Theta1(:,2:end)];
Theta2_grad = Theta2_grad/m + lambda/m*[zeros(num_labels,1) Theta2(:,2:end)];
  
%grad = 1/m*X'*(h-y) + lambda/m*theta;
%grad(1) = grad(1) - lambda/m*theta(1);













% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end