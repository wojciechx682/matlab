close all
clear all
clc

A=[ 0.1 0.2; 0.3 0.1; 0.5 0; 1 0; 0 1;]
B=[ 300; 300; 400; 0; 0;]
Z=[ -1; -1; -1; 1; 1;]
F=[90 55]

pkt=[];

for i=1:size(A,1)-1
    for j=(i+1):size(A,1)
        Ax=[ A(i,:); A(j,:) ]
        Bx=[ B(i); B(j) ]
        P = inv(Ax)*Bx
        if det(Ax)~=0
               pkt=[pkt; P']
        end
    end
end
pkt

Rozw=[]

for i=1:size(pkt,1)    %punkty
    
    licznik=0;
    
     for j=1:length(Z)                   %ograniczenia
        
         if Z(j) == -1
             if A(j,1)*pkt(i,1)+ A(j,2)*pkt(i,2)<= B(j)
                 licznik=licznik+1;
                 Rozw(j,1)=pkt(j,1); 
                 Rozw(j,2)=pkt(j,2);
             end
                 
         elseif Z(j) == 1
             if A(j,1)*pkt(i,1)+ A(j,2)*pkt(i,2)<= B(j)
                 licznik=licznik+1;
                 Rozw(j,1)=pkt(j,1); 
                 Rozw(j,2)=pkt(j,2);
             end
             %Rozw(j,1)=pkt(j,1); 
             %Rozw(j,2)=pkt(j,2);
         else
             
         end
     end
     
     if licznik == length(Z)  % czy licznik jest równy licznie ograiczen
            %Rozw=[]
     end
end
%Rozw=[];
%Rozw(1,1)=2;  
Rozw
F
Fcel=[]; % funkcja celu

%E(1,1)=[ F(1,1)*Rozw(1,1)+ F(1,2)*Rozw(1,2) ]
%E(2,1)=[ F(1,1)*Rozw(2,1) + F(1,2)*Rozw(2,2)]
%E(3,1)=[ F(1,1)*Rozw(3,1)+ F(1,2)*Rozw(3,2) ]
%E(4,1)=[ F(1,1)*Rozw(4,1)+ F(1,2)*Rozw(4,2) ]
%E(5,1)=[ F(1,1)*Rozw(5,1)+ F(1,2)*Rozw(5,2) ]

for i=1:licznik
    Fcel(i,1)=[ F(1,1)*Rozw(i,1) + F(1,2)*Rozw(i,2)]
end

[wart,ind]=max(Fcel);

wart
ind

x1=pkt(ind,1);
x2=pkt(ind,2);

Rozw
Fcel

pkt

x1   % 
x2










               