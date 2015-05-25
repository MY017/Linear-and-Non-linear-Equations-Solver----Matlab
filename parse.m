function [] = parse( S )
disp('From Parser');
[nRows , nCols] = size(S);
    for i = 1:nCols
        disp(S(1,i));
    end
end