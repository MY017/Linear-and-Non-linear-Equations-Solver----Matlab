clear all
Pointer = fopen('omar.txt');
syms A;
Line = fgetl(Pointer);
while ( ischar(Line) )
    A = [A Line];
    Line = fgetl(Pointer);
end
if(size(A) == 0)
    disp('Invalid');
    clear all
    return
end
parse(A);
fclose(Pointer);