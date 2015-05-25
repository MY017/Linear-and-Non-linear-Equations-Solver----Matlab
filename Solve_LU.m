function [ x ] = Solve_LU( A , b )
%% Elawel call el LU, 7yreturn el L wel U
% Kammel elba2y zy elmo7adra 3ady
% solve for d then solve for x
[L , U] = My_LU_Dec(A);
d = Forward(L,b);
x = Backward(U,d);
end

