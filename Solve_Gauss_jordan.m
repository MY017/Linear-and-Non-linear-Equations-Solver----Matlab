function [ x ] = Solve_Gauss_jordan( Aug )
[m,n]=size(Aug);
for j=1:m-1
    for z=2:m
        if Aug(j,j)==0
            t=Aug(1,:);Aug(1,:)=Aug(z,:);
            Aug(z,:)=t;
        end
    end
    for i=j+1:m
        Aug(i,:)=Aug(i,:)-Aug(j,:)*(Aug(i,j)/Aug(j,j));
    end
end
 
for j=m:-1:2
    for i=j-1:-1:1
        Aug(i,:)=Aug(i,:)-Aug(j,:)*(Aug(i,j)/Aug(j,j));
    end
end
 
for s=1:m
    Aug(s,:)=Aug(s,:)/Aug(s,s);
    x(s)=Aug(s,n);
end
end