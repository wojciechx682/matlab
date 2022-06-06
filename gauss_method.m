function lab5()
clc
close all
clear all

p = 3;
switch p
    case 1
        A =  [2,2,1;1,4,1;0,2,1;]
        B =  [3;-1;1]      
    case 2       
        A =  [1,1,2;2,-1,2;4,1,4]
        B =  [-1;-4;2;]
    case 3
        A =  [1,1,1,0;2,2,1,-1;0,3,1,2;1,2,2,1;]
        B =  [4;6;-1;4;]  
    otherwise
        A =  [0,3,1;2,1,-1;-2,1,4;]
        B =  [-2;4;-4;]  
end
       
X = eliminacjaGaussa(A,B)
end

    function x=eliminacjaGaussa(A,b)    
    [m,n] = size(A);
  
    for k=1:n-1
        [p,r] = max(abs(A(k:n,k))); 
        w=k+r-1; 
        A([k,w],:) = A([w,k],:);
         b([k,w]) = b([w,k]);
    end
    
    for k=1:n-1          
        for i=k+1:n
            m=A(i,k)/A(k,k);
        for j=k+1:n
            A(i,j)=A(i,j)-m*A(k,j);
        end
            b(i) = b(i)-m*b(k);
        end
    end 
    
    for i=n:-1:1
    sum=0;
        for j=i+1:n
            sum = sum + A(i,j)*x(j);
        end
        x(i) = (b(i)-sum)/A(i,i);
    end
end







