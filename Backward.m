function [x] = Backward(U,d)
%Input: U an upper triangular nxn matrix
% b a vector of length n
%Ouput: x a vector of length n solution to Ux = b
%
[n,m] = size(d);
x(n,1) = d(n,1)/U(n,n);
for i = n-1:-1:1
    x(i,1) = ( d(i,1) - U(i,i+1:n)*x(i+1:n,1) ) /U(i,i);
end