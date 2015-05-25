function [L,U]  = My_LU_Dec(A)
[n,m] = size(A); %% Compute dims of A
U(1,:) = A(1,:); %% Copy first row of A zy mahowa
d = zeros(1,n);  %% Initialize a new vector of zeros (7a2olak eh este5damha ba3deen)
L = diag(d+1,0); %% Create the L array (b7ees en kol element feldiagonal bysawy 1)
for i = 1:n-1
    L(i+1:n,i) = A(i+1:n,i)/U(i,i); %% 7etet 7sab elcoeff. bta3et el L
    for j = i+1:n
        A(j,i:n) = A(j,i:n) - L(j,i)*U(i,i:n); %%Ba7seb elgoz2 bta3 el U Lkol row
    end
    U(i+1,i+1:n) = A(i+1,i+1:n); %Copies(adds) the new row
end
%% Bos de Sample run kda
%A =
%
%    2     3     1
%     4     5     6
%     7     8     9
     
%[n,m] = size(A); %%Compute dims of A
%U(1,:) = A(1,:)
%d = zeros(1,n)
%L = diag(d+1,0)
%for i = 1:n-1
%   L(i+1:n,i) = A(i+1:n,i)/U(i,i)
%   for j = i+1:n
%       A(j,i:n) = A(j,i:n) - L(j,i)*U(i,i:n)
%   end
%   U(i+1,i+1:n) = A(i+1,i+1:n)
%end
%
%n = 
%     3
%     
%m = 
%     3
%
%U(1,:) = A(1,:)
%U =
%
%     2     3     1
%
%
%d = zeros(1,n)
%d =
%
%     0     0     0
%
%
%L = diag(d+1,0)
%L =
%
%    1     0     0
%    0     1     0
%    0     0     1
%
%
%L(i+1:n,i) = A(i+1:n,i)/U(i,i) @i = 1
%L =
%
%    1.0000         0         0
%    2.0000    1.0000         0
%    3.5000         0    1.0000
%
%
%A(j,i:n) = A(j,i:n) - L(j,i)*U(i,i:n) @i = 1 , j = i+1 ... Elkalam da mn
%ba3d elrow elawalny L8ayt a5er row elly howa row rakam n
%A =
%
%     2     3     1
%     0    -1     4
%     7     8     9
%
%
%A =
%
%    2.0000    3.0000    1.0000
%         0   -1.0000    4.0000
%         0   -2.5000    5.5000
%
%
%U =
%
%     2     3     1
%     0    -1     4
%
%
%L =
%
%    1.0000         0         0
%    2.0000    1.0000         0
%    3.5000    2.5000    1.0000
%
%
%A =
%
%    2.0000    3.0000    1.0000
%         0   -1.0000    4.0000
%         0         0   -4.5000
%
%
%U =
%
%    2.0000    3.0000    1.0000
%         0   -1.0000    4.0000
%         0         0   -4.5000