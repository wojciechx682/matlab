function [] = lab14_szablon()
clc
close
clear

wybor = 3;

switch wybor
    case 1
        f = @(x,y) x.^2+y.^2;
        xp = -10;             %początek przedziału
        xk = 10;              %kraniec przedziału
        yp = -10;
        yk = 10;
        xo = 8;              %punkt startowy
        yo = -10;
        krok = 1;            
     case 2 
         f=@(x,y)-cos(x).*cos(y).*exp(-1*((x-pi).^2+(y-pi).^2));  
         xp = 2;
         xk = 4;
         yp = 2;
         yk = 4;
         xo = 2;
         yo = 2;
         krok = 0.1;
     otherwise 
         f = @(x,y) (1-8.*x+7.*x.^2-(7/3).*x.^3+(1/4).*x.^4).*((y.^2).*exp(-1.*y));
         xp = 0;
         xk = 5;
         yp = 0;
         yk = 5;
         xo = 5;
         yo = 5;
         krok = 0.2;
end

% funkcja zwraca współ. minimum, liczbę itercji, dx, dy - współrzędne odwiedzonych punktów 
                                             %dokładność
[ x0, y0, dx, dy, iteracje ]=sww(f,xo,yo,krok,0.01,xp,xk,yp,yk);
[x0, y0, f(x0, y0), iteracje]


subplot(2,1,1)   %rysujemy dwa okna wykresu
% wykres funkcji 3d na zadanym przedziale - meshgrid + mesh
[x,y]=meshgrid(xp:0.1:xk, yp:0.1:yk);
mesh(x, y, f(x,y));    %albo surf
hold on
% narysowanie punktu ze znalezionym minimum
% plot3();  %DO ODKOMENTOWANIA; punkt reprezentujący minimum

% wykres konturowy
subplot(2,1,2);
z=f(x,y);
[c,h]=contour(x,y,z);
clabel(c,h);
hold on

% narysowanie i podpisanie punktu poczatkowego
plot(xo,yo,'r*');
text(xo,yo,'START'); %wstawia tekst do wskazanych współrzędnych
% narysowanie i podpisanie punktu koncowego - znalezionego minimum
plot(x0,y0,'r*');          %DO ODKOMENTOWANIA
text(x0,y0,'STOP');        %DO ODKOMENTOWANIA

% narysowanie sciezki - linie pomiędzy kolejnymi punktami
for i=1:length(dx)-1
%wsp.     x   y
     line([dx],[dy],'Color', 'k', 'Linewidth',1); %sciezka; DO ODKOMENTOWANIA
     contour(x,y,z,[f(dx(i),dy(i)),f(dx(i),dy(i))]);
end

end

function [ x0, y0, tablx, tably, iteracje xx] = sww( f, xpocz, ypocz, krok, eps, xmin, xmax, ymin, ymax )
x0 = xpocz;
y0 = ypocz;

iteracje = 0;
tablx = [xpocz];
tably = [ypocz];

%P1=[x0, y0]+krok.*[1 0];
%P2=[x0, y0]+krok.*[0 1];
%P3=[x0, y0]+krok.*[-1 0];
%P4=[x0, y0]+krok.*[0 -1];

h = eps;

der_x = @(x,y) (f(x+h,y)-f(x-h,y))/(2.*h);

der_y = @(x,y) (f(x,y+h)-f(x,y-h))/(2.*h);

i=0;
%while((der_x(x0,y0)>eps)&&(der_y(x0,y0)>eps))
while((i<200))
    iteracje=iteracje+1;
    i=i+1;
    P1=[x0, y0+krok];
    P2=[x0+krok, y0];
    P3=[x0, y0-krok];
    P4=[x0-krok, y0];


    f1=f(P1(1),P1(2));
    f2=f(P2(1),P2(2));
    f3=f(P3(1),P3(2));
    f4=f(P4(1),P4(2));
    
    A = [f1 f2 f3 f4];
    
    index = find(A == min(A(:)))
    index=index(1);
    if(index==1)
        P=P1;
    elseif(index==2)
        P=P2; 
    elseif(index==3)
        P=P3;
    else
        P=P4;
    end
    x0=P(1);
    y0=P(2);
    tablx(end+1)=x0;
    tably(end+1)=y0;
end

x0
y0


end
