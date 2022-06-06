clc
close all
clear all

% wektor z godzinami 
G = [6,9,11,14,16];
% wektor z temperaturami
T = [4,5,7,8,7];
    u=[8.15]        % szukana temperatura
    z=1;
    v=0;           % wartość interpolacji dla danego u
    
%Ilość węzłów
N = length(G);   
    
K = zeros(N, N+1);  % Tabela ilorazów różnicowych 
L=zeros(N,z);
% wpisujemy godziny do pierwszej kolumny
K(:,1) = G';
K(:,2) = T';
        
            %K(1,3)= (K(2,2)-K(1,2))/(K(2,1)-K(1,1)); ???

for k = 3:N+1    % pętla po kolumnach
    for w = 1:N-k+2
        K(w,k)=(K(w+1,k-1) - K(w,k-1))/(K(w+k-2,1) - K(w,1));    % w - wiersz, k - kolumna
    end    
end   

z=6:0.01:16;
p=zeros(1,length(z));
W=K(1,2:end);
for l=1:length(z)
        for k=1:N
            I=1;
            for j=1:k-1
                    I=I*(z(l)-K(j,1));                   
            end
             p(l)=p(l)+(W(k)*I);
        end
end


K
%plot(z,p)
n=length(G);     
m=length(u);  
w=ones(1,m);    
q=ones(1,n);   

for i=1:n
        w=w.*(u-G(i));
        for j=1:n
            if j~=i
                q(i)=q(i)*(G(i)-G(j));
            end
        end
    end
for i=1:n
        L(i,:)=w./(u-G(i))/q(i);
        v=v+T(i)*L(i,:);
    end
v % wartosc temperatury o godzinie 8.15




plot(z,p)
hold on
plot(v,'r*')