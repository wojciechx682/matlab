function MN_lab10()
clc
close all
clear all

wybor = 1;

switch wybor
    case 1
        f = @(x) exp(x-1)-2;
        a=-1;
        b=2;        
    case 2
        f = @(x) 2.^(-x)+exp(x)+2.*cos(x)-6;
        a=1;
        b=3;
    case 3
        f = @(x) log(x+2/3);
        a = -0.5;
        b = 2;   
     case 4
        f = @(x) x.^3-2.*x-5;
        a = 0;
        b = 3;   
end

tol = 10^(-5); 
ftol = 10^(-4); 

tic
[X N] = sieczne(f, a, b, tol, ftol);
toc

tic
[X1 N1] = styczne(f, a, b, tol, ftol);
toc

x=a:0.01:b;
plot(x, f(x));
hold on

plot(X, f(X), 'r^');
plot(X1, f(X1), 'bs');

end
         
function [xn, n] = sieczne(f, a, b, tol, ftol);

der = @(x,h) (f(x+h)-2*f(x)+f(x+h))/(h.^2);

if(f(a)*der(a,tol)>0)
    x0=a;
    x1=b;
else
    x0=b;
    x1=a;
end

n=0;

while (true)
     n=n+1;
    xn=x1-f(x1)*((x1-x0)/(f(x1)-f(x0)));
    x0=x1;
    x1=xn;
    fn=f(xn); 
  
    if (abs(xn-x0)<=tol)
        break;
    end     
    if ((abs(fn)<=ftol))
        break;        
    end 
end
xn
n  
end
     
function [xn, n] = styczne(f, a, b, tol, ftol);
der = @(x,h) (f(x+h)-2*f(x)+f(x+h))/(h.^2);
der1 = @(x,h) (f(x+h)-f(x-h))/(2.*h);

if(f(a)*der(a,tol)>0)
    x0=a;    
else
    x0=b;   
end

n=0;

while (true)
    f0=f(x0);   
  
    f1=der1(x0,tol);
       
    
    x0=x0-(f0/f1);      
    
     if ((abs(f0)<=ftol))
        break;
     end
     n=n+1;     
end
    xn=x0; 
xn
n
end