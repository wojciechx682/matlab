function MN_lab11()
clc
close all
clear all

Xg = [ 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150 ]
Yg = [ 0, 26, 30, 28, 21, 12, 8, 12, 18, 20, 17, 16, 21, 26, 30, 0] 

Xd = [ 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150 ]
Yd = [ 0, -30, -37, -40, -33, -15, -5, -8, -16, -21, -20, -17, -20, -24, -22, 0]

g = griddedInterpolant (Xg, Yg, 'spline');
d = griddedInterpolant (Xd , Yd, 'spline');
g(1)
g(5)
h=13;
a=0;
b=150;
N=(b-a)/h;
h
N

%srodek=a+((b-a)/(2*N));
%srodek=(a+a+h)/2;
%srodek
A=a
P1=0
P2=0

for i=a:h:b-h
    
    %srodek=((a+(h*i)+a+(h*(i+1)))/2);
    
    srodek=((A+A+h)/2);    
    
    %if(A<b...
    
    A=A+h
    
    %srodek
    
    P1=P1+h*g(srodek)
    P2=P2+h*abs(d(srodek))
    
    %s=s+f(xp+i.*dx);
    %s=s*dx;
    %s=s+f(srodek);
    %srodek=srodek+dx;
    %srodek=(a+a+h)/2;
    %srodek=a+(b-a)/2*N;
        %S=S+g(srodek)*h;
       %srodek=srodek+h;
    
    %S1=S1+g(a+i*(h/2))*h;
    %S2=S2+abs(d(a+i*(h/2)))*h;
    %wartość funkcji (wysokosć) * podstawa prostokąta
end
if(A<b)
    Y1=((b-A)*g((A+((b-A)/2))))
    Y2=((b-A)*d((A+((b-A)/2))))
    
   P1=P1+Y1
   P2=P2+Y2
end

%Y=

for i=1:16
    plot(Xg(i),g(Xg(i)),'r*')
    hold on
     plot(Xd(i),d(Xd(i)),'r*')
    hold on
end

%plot(Xg(i),g(Xg(i)),'r*')
x=0:1:150;
plot(x,g(x));
hold on
y=0:1:150;
plot(y,d(y));
%plot(Xg,g(Xg))
hold on
%plot(Xd,d(Xd))
hold on
a=0
h
srodek=((a+a+h)/2); 
srodek
%A=a 
for  i=0:N-1
    
    x1=a
    y1=0
    x2=a+h
    y2=0
    x3=a+h
    y3=g(srodek)
    x4=a
    y4=g(srodek)
    patch('Vertices',[x1, y1; x2, y2; x3, y3; x4, y4], 'Faces', [1, 2, 3, 4], 'FaceColor', [0 0.4470 0.7410], 'FaceAlpha', 0.4)
    
    plot(srodek,g(srodek),'bo')
    hold on
    
    x1=a
    y1=0
    x2=a+h
    y2=0
    x3=a+h
    y3=d(srodek)
    x4=a
    y4=d(srodek)
    patch('Vertices',[x1, y1; x2, y2; x3, y3; x4, y4], 'Faces', [1, 2, 3, 4], 'FaceColor', [0 0.4470 0.7410], 'FaceAlpha', 0.4)

    plot(srodek,d(srodek),'bo')
    hold on
    
    
    
    
    a=a+h
    srodek=((a+a+h)/2);    
    
    
    
end 
x1
x2
b

if(x2<b) %rysowanie ostatniego prostokątu...
    srodek=x2+(b-x2)/2;
    srodek
    g(srodek)
  %plot(x2,0,'r*')
    y=x2
    x1=y %144...
    y1=0
    x2=b
    y2=0
    x3=b
    y3=g(srodek)
    x4=y
    y4=g(srodek)
    patch('Vertices',[x1, y1; x2, y2; x3, y3; x4, y4], 'Faces', [1, 2, 3, 4], 'FaceColor', [0 0.4470 0.7410], 'FaceAlpha', 0.4)

    plot(srodek,g(srodek),'bo')
    hold on
    
  
  
   
    y3=d(srodek)    
    y4=d(srodek)
    patch('Vertices',[x1, y1; x2, y2; x3, y3; x4, y4], 'Faces', [1, 2, 3, 4], 'FaceColor', [0 0.4470 0.7410], 'FaceAlpha', 0.4)

    plot(srodek,d(srodek),'bo')
    hold on 
    
end

%S1
%S2
%S=S1+S2

format('long')
P1
P2
P=P1+P2
%plot(Xg,Yg,'r*')

end