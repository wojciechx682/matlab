function lab7()

zad1()
zad2()

end

%% funkcja realizujaca zadanie 1
function [] = zad1()

% Musimy sami odczytać węzły interpolacyjne

Xg = [0, 5, 19, 45, 51, 61, 100, 101, 103, 105, 110, 190, 195]
Yg = [30, 35, 83, 83, 75, 83, 83, 83, 83, 83, 83, 83, 30]

Xd=[0, 9, 25, 35, 50, 60, 140, 150, 160, 165, 175, 185, 195]
Yd=[30, 21, 10, 0, 21, 15, 15, 0, 15, 15, 0, 15, 30]

%subplot(1,3,j)
%plot(Z,w);
%hold on
%plot(x,y,'r*');

X=0:195;
Yg=interp1(Xg,Yg,X,'linear');
Yd=interp1(Xd,Yd,X,'linear');

subplot(2,4,1);
plot(X,Yg);
hold on
subplot(2,4,1);
plot(X,Yd)
hold on
plot(Xg,Yg,'r*');
hold on
plot(Xd,Yd,'r*')

X=0:195;
Yg=interp1(Xg,Yg,X,'nearest');
Yd=interp1(Xd,Yd,X,'nearest');

subplot(2,4,2);
plot(X,Yg);
hold on
plot(X,Yd)
hold on
plot(Xg,Yg,'r*');
hold on
plot(Xd,Yd,'r*')

% ....

end

%% funkcja realizujaca zadanie 2
function [] = zad2()

% Zjawisko pogorszenia jakości interpolacji na krańcach przedziału - to
% Efekt Rungego - (pogorszenie jakości interpolacji wielomianowej, mimo
% zwiększenia liczby jej węzłów)
% Aby uniknąć tego efektu, stosuje się interpolację z węzłami coraz gęściej 
% upakowanymi na krańcach przedziału interpolacji.

n = [5, 10, 15];
for j=1:3;
    
x = linspace(-15, 15, n(j));
y = -1./(36 + x.^2);
y = y'; 
V = zeros(n(j),n(j));

%macierz vandermonde'a
for w=1:n(j)         % wiersze macierzy
    for k=0:n(j)-1        
            V(w,k+1)=x(w)^k;
    end
end  

A=inv(V)*y;

Z=-15:0.01:15;

w=0;
i=1;
for i=1:n(j)            % wiersze macierzy
    w=w+A(i)*Z.^(i-1);
end

subplot(1,3,j)
plot(Z,w);
hold on
plot(x,y,'r*');
end

end