function MN_lab9()
clc
close all
clear all

wybor = 2;

switch wybor
    case 1 
        f = @(x) cos(x);
        a = 0;
        b = 2;
    case 2
        f = @(x) 2.^(-x)+exp(x)+2.*cos(x)-6;
        a = 1;
        b = 3;
    otherwise
        f = @(x) (x+2).^5;
        a = -3;
        b = 0;
end

tol = 10.^(-5); %dokładność dla x
ftol = 10.^(-4); %dokładność dla f(x)

%x1=a:0.01:b;
%plot(x1, f(x1));

%x2=a:0.01:b;
%plot(x2, f(x2));

x2=a:0.01:b;
plot(x2, f(x2));
hold on

%[x_bisekcja, n_bisekcja] = bisekcja(f, a, b, tol, ftol)
tic
[X N] = bisekcja(f, a, b, tol, ftol)
toc

tic
[Y N] = falsi(f, a, b, tol, ftol)
toc

%tic
%[X N] = falsi(f, a, b, tol, ftol)
%toc
%[x_falsi, n_falsi] = falsi(f, a, b, tol, ftol)
%plot(X);

plot(X,f(X),'r^');
hold on
plot(Y, f(Y),'bs');
hold on

end

function [x, n] = bisekcja(f, a, b, tol, ftol)
x = 0; 
n = 0; %liczba iteracji potrzebna do znalezienia rozwi¡zania.

if f(a)*f(b)<0
    x=(a+b)/2;
    while abs(f(x))>ftol && abs(a-x)>tol
        n=n+1;
        if f(a)*f(x)<0
            b=x;
        else
            a=x;            
        end
        x=(a+b)/2;              
    end
end          
end

function [X, n] = falsi(f, a, b, tol, ftol)
X = 0;
n = 0;
der = @(x,h) (f(x+h)-2*f(x)+f(x-h))/h.^2;

if f(a)*der(a,10^(-5))<0
    X=a;
    Xs=b;
        X1=b;
        
else    
    Xs=a;
    X=b;
        X1=a;
end
ac=abs(f(X));

while ac>ftol && abs(X1-X)>tol
        X1=X;
        X=Xs-f(Xs)/(f(X)-f(Xs))*(X-Xs);        
end
n=n+1;
end
