function [] = Lab17_szablon()
clc
close all
clear

wybor = 2;

switch wybor
    case 1
        f = @(x,y) x.^2 + y.^2;
        xp=-10;
        xk=10;
        yp=-10;
        yk=10;
        xo=-10;
        yo=10;
        plk = 0.1;
    case 2
        f= @(x,y) 3.*x.^4-2/3.*y.^3+2.*x.^2.*y-2.*x.^2+y.^2;
        xp=-1;
        xk=1;
        yp=-1.5;
        yk=1;
        xo=-1;
        yo=1;
        plk = 0.02;        
    case 3
        f= @(x,y) (1-8.*x+7.*x.^2-7/3.^3+1/4.*x.^4).*(y.^2.*exp(-1.*y));
        xp=0;
        xk=5;
        yp=0;
        yk=5;
        xo=5;
        yo=5;
        plk = 0.1;        
    otherwise
        f= @(x,y) 100.*(y-x.^2).^2+(1-x).^2;
        xp=-2;
        xk=2;
        yp=-1;
        yk=3;
        xo=-2;
        yo=3;
        plk = 0.1;   
end

eps = 0.001;

[x0, y0, dx, dy, it] = najszybszy_spadek(f, xo, yo, eps);
[x0, y0, it]

figure;
subplot(2,1,1)
%%% przygotowanie siatki do rysowania wykreu funkcji 3d
%[x,y]=meshgrid();
%mesh(x,y,f(x,y));
hold on
%%% rysowanie minimum
%plot3(,,,'r.','Markersize', 10);

subplot(2,1,2);
%z=f(x,y);
%[c,h]=contour(x,y,z);
%clabel(c,h);
hold on
%%% narysowanie i podpisanie punktu startowego
%plot(,,'r*');
%text(,,'START');
%contour(x,y,z,[f(dx(1),dy(1)),f(dx(1),dy(1))])

for i=1:length(dx)-1
    %%% narysowanie sciezki laczacej kolejne punkty z dx, dy
    %line([,],[,],'Color', 'r', 'Linewidth',2);
    plot(dx(i+1),dy(i+1),'r*');
end

%%% narysowanie i podpisanie punktu koncowego
%plot(,,'r*');
%text(,,'STOP');

%%% narysowanie wykresu zbieznosci
figure
hold on
%plot()
%plot()
end

function [x0, y0, dx, dy, it] = najszybszy_spadek(f, x0, y0, eps)
it = 0;
dx = x0;
dy = y0;

i=0;

P0=[x0 y0];
P0=transpose(P0);
gr=gradient(f, P0(1), P0(2));           % i = 1;
d=-1.*gr;                               % kierunek poszukiwań:

fun = @(a) f(P0(1)+d(1)*a,P0(2)+d(2)*a);
options = optimset('TolFun',10.^(-6),'TolX',10.^(-6));

while(i<400)
    i=i+1;
    it=i+1;
%a = fminbnd(@f,x0,x0)

a = fminbnd(fun,0,1,options);
a
%f(Pi+d.*a)  %osobno współrzędne x, y
%przekazujemy 4 parametry :
%fminbnd: @@f(,)               

%wyznaczenie Pi+1

Pi=P0+a.*d;
Pi
% nowy gradient i kierunek dla Pi+1 (wróc do punktu 2)

gr=gradient(f, Pi(1), Pi(2));  % i = 1;
d=-1.*gr;  

%f(P0(1),P0(2))


x0=Pi(1);
y0=Pi(2);

%i=i+1;

%norma=sqrt(gr*transpose(gr));

%if(norma<eps)
%    break;
end


%end

end


function G = gradient(f, x, y)

h = 2^(-20);

x0=x;
y0=y;

der_x = (f(x0+h,y0)-f(x0-h,y0))/(2.*h);
der_y = (f(x0,y0+h)-f(x0,y0-h))/( 2.*h);

%%% wyznaczenie gradientu
G(1) = der_x
G(2) = der_y
G = G';
end