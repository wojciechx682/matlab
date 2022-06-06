clc
close all 
clear all

format short
a = 0.2 + 0.2 + 0.2
a==0.6
format long e

format long e
x=[ exp(1) , -pi , sqrt(2) , - psi(1) , log10(2) ];
y = [1486.2497 , 878366.9879 , -22.37492 , 4773714.647 , 0.000185049];

x*y'

sum(x.*y)

suma1 = 0
for i=1:5
   suma1=suma1+(x(i)*y(i))
end 

suma2 = 0
for i=5:1
   suma2=suma2+(x(i)*y(i))
end 

B1=abs(sum(x.*y)-(x*y'));
B2=abs(suma1-(x*y'));
B3=abs(suma2-(x*y'));
bar([B1,B2,B3]);

format long e

x=29/13

y=29-13*x

x1=29/1300

y1=29-1300*x1

x=10.^[4:10];
x=double(x);
a=double(sqrt(1+x.^2));
w1=double(x-a);
w2=double((-1)./(x+a));

x=single(x);
a=single(sqrt(1+x.^2));
w1=single(x-a);
w2=single((-1)./(x+a));


d=10.^-3
x1 = linspace(2-d,2+d,1000);

f1 = @(x) (x-2).^4;

plot(x1, f1(x1))




