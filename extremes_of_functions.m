function lab13()
close all
clear all
clc

wybor = 4;

switch wybor
    case 1
        f = @(x) (x.^2) - x;
        a=0.25;
        b=0.75;
        eps=1e-4;
    case 2
        f = @(x) ((1/3).*x.^2)-((13/7).*x)+11;
        a=-10;
        b=10;
        eps=1e-4;
    case 3
        f = @(x) x.^4-12.*x.^3+x+4;
        a=-2;
        b=2;
        eps=1e-4;
    otherwise
        f = @(x) -x.^3+3.*x.^2-3.*x;
        a=-2;
        b=-1;
        eps=1e-4;
end

tic
[x1, n1] = metoda1(f, a, b, eps)
toc
disp('Ekstremum (metoda połowienia): ');

tic
[x2, n2] = metoda2(f, a, b, eps)
toc
disp('Ekstremum (metoda połowienia): ');

t=a:0.01:b;
plot(t,f(t))
hold on;
plot(x1, f(x1), 'ro')
plot(x2, f(x2), 'bx')
%plot(x3, f(x3), 'rx')
%f(x1)

end

function [xm, n1] = metoda1(f, a, b, eps)
n1=0;
x1=0;
h=eps;
der = @(x) (f(x+h)-f(x-h))/(2.*h);

if((der(a)<0)&&(der(b>0)))
    
    xm=(a+b)/2;    
    n1=n1+1;

while((b-a>eps)&&(abs(der(xm))>eps))
    
    n1=n1+1;
    
    L=b-a;    
    
    x1=a+0.25*L;
    x2=b-0.25*L;
    
    if(f(a)>f(b))
        if(f(x1)>f(b))
            a=xm;
            xm=x2;
        else
            a=x1;
            b=x2;
        end
    else
        b=xm;
        xm=x1;
    end   
end 

    
else
    if(f(a)<f(b))
        xm=a;
    else
        xm=b;
    end
end

end

function [xm, n2] = metoda2(f, a, b, eps)
n2=0;
x0=a;
h=eps;

der1 = @(x) (f(x+h)-f(x-h))/(2.*h);
der2 = @(x) (f(x+h)-2.*f(x)+f(x-h))/(h.^2);

if((der1(a)<0)&&(der1(b)>0))

    n2=n2+1;

xm=x0-((der1(x0))/(der2(x0)))

while(abs(der1(xm))>eps)   
    n2=n2+1;
    
    xm=x0-((der1(x0))/(der2(x0)))
    x0=xm;
    
end 
    
else
    if(f(a)<f(b))
        xm=a;
    else
        xm=b;
    end
end

end
