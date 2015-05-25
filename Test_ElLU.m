[L , U] = My_LU_Dec(A);
d = Forward(L,b);
x = Backward(U,d);
x