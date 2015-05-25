function [ x ] = Solve_Naive_Gauss( A,b )
%% Initialize variables
[n, n] = size(A);
[n, k] = size(b);
x = zeros(n,k);      % Initialize result vector
%% Forward Elimination
for i = 1:n-1
    m = -A(i+1:n,i)/A(i,i); % calculate multiplier for each row
    %factor = aik / akk
    A(i+1:n,:) = A(i+1:n,:) + m*A(i,:);
    %for j = k+1 to n
    %    aij = aij – factor * akj ........ Ana 3amlo negative mn el awel
    b(i+1:n,1) = b(i+1:n,1) + m*b(i,1);
    %bi = bi – factor * bk ......... 3ashan 3amlo negative mn elawel
end;
x(n,1) = b(n,1)/A(n,n);         %xn = bn / ann
%% Backward Substitution(Evaluation)
for i = n-1:-1:1
    x(i,1) = (b(i,1) - A(i,i+1:n)*x(i+1:n,1))/A(i,i);
    %for i = n-1 downto 1
    %   sum = 0
    %   for j = i+1 to n
    %       sum = sum + aij * xj
    %   xi = (bi – sum) / aii
end
end

