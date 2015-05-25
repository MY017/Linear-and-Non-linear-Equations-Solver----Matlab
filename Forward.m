function [d] = Forward(L,b)
%input: L a lower triangular n x n matrix
% b a nxm matrix
%output: x matrix solution of Ld=b
%
[n,m] = size(b);
d(1,1) = b(1,1)/L(1,1);
for i = 2:n
    d(i,1) = ( b(i,1) - L(i,1:i-1)* d(1:i-1,1) )/L(i,i);
end