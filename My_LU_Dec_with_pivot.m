function [L,U,P,RI]= mylupiv(A)
%PA=LU factorization with partial pivoting
%input: matrix A
%output: L lower triangular matrix
% U upper triangular
% P permutation matrix elly hya elpivot ya3ny
% RI number of row interchanges
%
[n,m] = size(A);
P = eye(n);
U(1,:) = A(1,:);
d = ones(1,n);
L = zeros(n);
RI = 0;
for i = 1:n-1
    [mx,p]=max(abs(A(i:n,i)));
    p = p-1+i;
    if (p ~= i)
        RI = RI + 1;
        % rows interchanges in A
        tmp=A(p,i:n);
        A(p,i:n)=A(i,i:n);
        A(i,i:n)=tmp;
        % rows interchanges in L
        tmp= L(i,1:i-1);
        L(i,1:i-1)=L(p,1:i-1);
        L(p,1:i-1) = tmp;
        % rows interchanges in P
        tmp=P(p,:);
        P(p,:)=P(i,:);
        P(i,:)=tmp;
    end
    U(i,i:n) = A(i,i:n); %%Copy the row of A to U
    L(i+1:n,i) = A(i+1:n,i)/U(i,i); %%Calculate L factors (zy el LU el3ady)
    %Gaussian elimination
    for j = i+1:n
        A(j,i:n) = A(j,i:n) - L(j,i)*U(i,i:n);
    end
end
U(n,n) = A(n,n);
L = L+diag(d);