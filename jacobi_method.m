clc
close all
clear all
% -----------------------------------------------------------------------
k_max=10000;   % Max. wartość iteracji dla kolejnych przybliżeń rozwiązań

a = 3;

switch a
    case 1       
        A = [2 2 1; 1 4 1; 0 1 2;];    
        b = [3; -1; 1;];
    case 2
        A = [4 1 4; 2 -1 2; 1 1 2;];
        b = [2; -4; -1;];
    case 3
        A = [2 1 -1; 0 3 1; -2 1 4;];
        b = [4; -2; -4];
end

X = solve_Jacobi(A, b, k_max)

function [X] = solve_Jacobi(A, b, k_max)

N=length(A);

H=zeros(N,N);

X=[];                 %Wektor rozwiązań 

G=[];        

for i=1:N  
    
    G(i)=b(i)/A(i,i);
    X(i)=G(i);  
    
    for k=1:N
        if(i~=k)
           H(i,k)=-A(i,k)/A(i,i);
        end
    end    
end

A, b, H, G

for k=1:k_max 
    
    for i=1:N
       
       sum=0;
       
       for j=1:N
          sum=sum+(H(i,j)*X(j)); 
       end   
       
       X(i)=G(i)+sum;      
    end   
end
end
