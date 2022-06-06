function [] = Lab16_szablon()
clc
close all
clear

wybor = 3;

switch wybor
    case 1
        f = @(x,y) x.^2 + y.^2;
        xp = -10;
        xk = 10;
        yp = -10;
        yk = 10;
        xo = -10;
        yo = 10;
        plk = 0.1;
        krok = 1;
    case 2
         f= @(x,y) 3.*x.^4-2/3.*y.^3+2.*x.^2.*y-2.*x.^2+y.^2;
         xp=-1;
         xk=0.4;
         yp=-1;
         yk=1;
         xo=-1;
         yo=1;
         plk =0.02;
         krok = 0.1;  
    case 3
         f= @(x,y) 5*(x-1).^2+10*(y-3).^2
         xp=-20;
         xk=20;
         yp=-20;
         yk=20;
         xo=-10;
         yo=10;
         plk =0.2
         krok =1;
     otherwise
         f= @(x,y) 100*(y-x.^2).^2+(1-x).^2;
         xp=-2;
         xk=2;
         yp=-1;
         yk=3;
         xo=-2;
         yo=3;
         plk =0.1;
         krok =0.5;
end
eps = 0.001;

[ x0, y0, dx, dy, iteracje ]=newton(f,xo,yo,krok,eps);
[ x0, y0, f(x0, y0), iteracje ]

%[x]=gradient(f,3,3);
%[x]

%[ x01, y01, dx1, dy1, iteracje1 ]=grad_prostyK(f,xo,yo,krok,eps);
%[x01, y01, f(x01, y01), iteracje1]

figure;
% wykres funckji 3d z zaznacoznymi miejscami zerowymi odnalezionymi
% przez podstawowa wersje algorytmu i jej modyfikacje
subplot(2,2,[1,2])
[x,y]=meshgrid(xp:plk:xk,yp:plk:yk);
mesh(x,y,f(x,y));
hold on
 plot3(x0,y0,f(x0,y0),'r.','Markersize', 10);
 %plot3(x01,y01,f(x01, y01),'g.','Markersize', 10);

% wyres poziomicowy dla podstawowej wersji metody
subplot(2,2,3);
hold on
z=f(x,y);
[c,h]=contour(x,y,z);
clabel(c,h);
plot(xo,yo,'r*');
text(xo,yo,'START');
plot(x0,y0,'r*');
text(x0,y0,'STOP');
contour(x,y,z,[f(dx(1),dy(1)),f(dx(1),dy(1))])
for i=1:length(dx)-1
    %line([dx,dy],[x0,y0],'Color', 'r', 'Linewidth',2);
    plot(dx(i+1),dy(i+1),'r*');
end
end


function [ x0, y0, tablx, tably, it, gr ] = newton( f, x0, y0, krok, eps)
tablx = [x0];
tably = [y0];

it=0;
i=0;

syms x y

h=eps;

Hs=hessian(f,[x,y])
while(i<400)

    
    it=it+1;
    i=i+1;
    
P0=[x0 y0];
P0=transpose(P0);

H{1,1}=matlabFunction(Hs(1,1),'vars',[x,y])
H{1,2}=matlabFunction(Hs(1,2),'vars',[x,y])
%H{1,3}=matlabFunction(Hs(1,3),'vars',[x,y,z])
H{2,1}=matlabFunction(Hs(2,1),'vars',[x,y])
H{2,2}=matlabFunction(Hs(2,2),'vars',[x,y])
%H{2,3}=matlabFunction(Hs(2,3),'vars',[x,y,z])
%H{3,1}=matlabFunction(Hs(3,1),'vars',[x,y,z])
%H{3,2}=matlabFunction(Hs(3,2),'vars',[x,y,z])
%H{3,3}=matlabFunction(Hs(3,3),'vars',[x,y,z])

%wyznaczenie Hesjanu dla konkretnego punktu (x0,y0):
He=[H{1,1}(x0,y0) H{1,2}(x0,y0); 
    H{2,1}(x0,y0) H{2,2}(x0,y0);];

He
He_inv=inv(He)   
%He_inv

[gr]=gradient(f, x0, y0);
    %gr=transpose(gr);
G=gr
TG=transpose(gr);
%G
%TG

%A=dot(G,TG);
%A

P1=P0-He_inv*TG;
%P1
%P1=P0-He_inv.*gr;
%P1

x0=P1(1);
y0=P1(2);

if((G.*He_inv*TG)<eps)
    break;
end

end

end

% metoda rozszerzona o zmniejszanie kroku


% funkcja liczaca gradient
function [G] = gradient(f, x0, y0)

h = 0.001;
%h = eps;
%f= @(x,y) 2.*x.^2+y.^2+x-y;

der_x = (f(x0+h,y0)-f(x0-h,y0))/(2.*h);
der_y = (f(x0,y0+h)-f(x0,y0-h))/( 2.*h);

G=[der_x der_y];

end