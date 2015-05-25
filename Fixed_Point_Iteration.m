function Fixed_Point_Iteration
%Fixed point iteration example.
%4x^2 = 10 - x^3 can be rewritten as x^2 = 0.25*(10 - x^3) 
%===> x = 0.5*(10- x^3)^0.5 if we take the postive root only.
%now we can use fixed point iteration.

i = 1;         
p0 = input('Initial Guess : ');
error = 0.0000001;
N = 100;
format long;
syms 'x'
g(x) = 0.5*((10 - (x^3))^0.5); %i.e. what we are trying to solve

while i <= N
    p = g(p0);                  %the next p value
    disp([p' ; p0' ; i]);
    if (abs((p - p0)) < error)    %stopping criterion using the required precision
        fprintf('Solution is %f \n', double(p))     %the output p is symbolic so need ot force it into a decimal
        return
    end
    i = i + 1;   
    p0 = p;         %update the value of i and p to continue the loop with

end
fprintf('Solution did not converge to within precision = %d in %d iterations \n', error, N)
end
