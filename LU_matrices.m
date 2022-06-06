function [] = lab6()
clc
close all
clear all
p = 4;
switch p
    case 1
        A = [2 2 1; 1 4 1; 0 1 2];
        B = [3;-1;1];
    case 2
        A = [4 1 4; 2 -1 2;1 1 2];
        B = [ 2;-4;-1];
    case 3
        A = [2 2 1 -1; 0 3 1 2; 1 2 2 1;1 1 1 0];
        B = [6; -1; 4; 4];
    otherwise
        A = [2 1 -1; 0 3 1; -2 1 4];
        B = [4;-2;-4];
end
[L, U] = rozkladLU(A)
[X] = wyznaczX(L,U,B)
end
%%%wyznaczenie macierzy L i U%%%
function [L, U] = rozkladLU(A)
n = size(A,1);
L = eye(n);
U = zeros(n);
for i=1:n 
    for j=1:n
        S1=0; 
            for k=1:i
                S1=S1+L(i,k)*U(k,j);
            end
        U(i,j)= A(i,j)-S1;
    end               
    for j=i:n
        if i~=j                   
        S1=0;
        
        for k=1:i
            S1=S1+L(j,k)*U(k,i);
        end       
        L(j,i)=(1/U(i,i))*(A(j,i)-S1);
        end       
    end   
end
end

%%%wyznaczenie rozwiazania%%%
function [X] = wyznaczX(L,U,B)
n = size(L,1);
Y = zeros(1,n);
X = zeros(1,n);

Y(1)=B(1);
for i=1:n
    S=0;
    for j=1:i-1
    S=S+L(i,j)*Y(j);
    Y(i)=B(i)-S;
    end
end

X(n)=Y(n)/U(n,n);
for i=n-1:-1:1
    S=0;
    for j=i+1:n;
        S=S+U(i,j)*X(j);
    end
    for j=i+1:n;
        X(i)=(1/U(i,i))*(Y(i)-S);
    end
       
    end
end
