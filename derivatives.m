function lab12_szablon()

z1()

z2()

z3()

end


function z1()
figure;

f =@(x) cos(2*x);
df = @(x) -2*sin(2.*x); % Analitycznie (ręcznie) obliczamy pierwszą pochodną
a = 0;
b = 6;
h = [1, 1/2, 1/4];

for i = 1:length(h) % jedna iteracja pętli tworzy nam jedną kolumnę wykresu
    xx = a:h(i):b;  % xx - określa dla jakich punktów liczymy pochodne
    
    subplot(3,3,i)
    hold on
    plot(xx, f(xx),'k')  %wykres funkcji f
    plot(xx,df(xx), 'r') % wykres pochodnej wyznaczonej analitycznie
    p2 = pochodna_z1(f,a,b,h(i),2); % funkcja oblicza wybrany pochodną z wybranego wzoru (2,3,5...określa ostatni parametr)
    plot(xx,p2, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p2-df(xx)).^2);
    title(['2pkt: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
    
    % 3-punktowy
    subplot(3,3,i+3)
    hold on
    plot(xx, f(xx),'k')
    plot(xx,df(xx), 'r')
    %
    p3 = pochodna_z1(f,a,b,h(i),3); % funkcja oblicza wybrany pochodną z wybranego wzoru (2,3,5...określa ostatni parametr)
    plot(xx,p3, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p3-df(xx)).^2);
    title(['3pkt: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
    
    % 5-punktowy
    subplot(3,3,i+6)
    hold on
    plot(xx, f(xx),'k')
    plot(xx,df(xx), 'r')
    %
    p5 = pochodna_z1(f,a,b,h(i),5); % funkcja oblicza wybrany pochodną z wybranego wzoru (2,3,5...określa ostatni parametr)
    plot(xx,p5, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p5-df(xx)).^2);
    title(['5pkt: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
end

end

function [p] = pochodna_z1(f,a,b,h,s)
    if s == 2 %
        p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                
           p(i) = (f(x+h)-f(x))/(h); 
           i = i + 1;
        end
    elseif s == 3 
        p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                
           p(i) = (f(x+h)-f(x-h))/(2.*h); 
           i = i + 1;
        end
    elseif s == 5
        p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                
           p(i) = (-f(x+2*h)+8*f(x+h)-8*f(x-h)+f(x-2*h))/(12.*h); 
           i = i + 1;
        end
    else
        p = NaN;
    end
end

function z2()


figure;

f = @(x) sin(x)+cos(2*x);
df = @(x) cos(x)-2*sin(2*x); 
a = 0;
b = 4;
h = [1/2, 1/4, 1/8];

for i = 1:length(h) 
    xx = a:h(i):b; 
    
    % 3-punktowy w przód
    subplot(3,3,i)
    hold on
    plot(xx, f(xx),'k')  %wykres funkcji f
    plot(xx,df(xx), 'r') % wykres pochodnej wyznaczonej analitycznie
    p2 = pochodna_z2(f,a,b,h(i),'p');
    plot(xx,p2, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p2-df(xx)).^2);
    title(['wprzód: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
    
    % 3-punktowy
    subplot(3,3,i+3)
    hold on
    plot(xx, f(xx),'k')
    plot(xx,df(xx), 'r')
    %
    p3 = pochodna_z2(f,a,b,h(i),'c');
    plot(xx,p3, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p3-df(xx)).^2);
    title(['centralny: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
    
    % 5-punktowy
    subplot(3,3,i+6)
    hold on
    plot(xx, f(xx),'k')
    plot(xx,df(xx), 'r')
    %
    p5 = pochodna_z2(f,a,b,h(i),'w');
    plot(xx,p5, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p5-df(xx)).^2);
    title(['wstecz: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
end

end

function [p] = pochodna_z2(f,a,b,h,s)
if s == 'p' % w przod
      p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                
           p(i) = (-3.*f(x)+4*f(x+h)-f(x+2*h))/(2*h);  
           i = i + 1;
        end   
elseif s == 'c' % centralny
    p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                 
           p(i) = (f(x+h)-f(x-h))/(2*h);  
           i = i + 1;
        end
elseif s =='w' % wstecz
   p = zeros(1, length(a:h:b));   
        i = 1;
        for x = a:h:b                
           p(i) = (f(x-2*h)-4*f(x-h)+3*f(x))/(2*h); 
           i = i + 1;
        end
else
    p = NaN;
end
end

function z3()
figure

%df = @(x) -4*sin(4*x)-1/2; % Analitycznie (ręcznie) obliczamy pierwszą pochodną
f = @(x) cos(4*x)-((1/2)*x);
dff = @(x) -16*cos(4*x) %DRUGA POCHODNA
a = 0;
b = 5;
h = [1, 1/2, 1/4];

for i = 1:length(h) 
    xx = a:h(i):b;     
    % 3-punktowy 
    subplot(2,3,i)
    hold on
    plot(xx, f(xx),'k')  %wykres funkcji f
    plot(xx,dff(xx), 'r') % wykres pochodnej wyznaczonej analitycznie
    p2 = pochodna_z3(f,a,b,h(i),3); 
    plot(xx,p2, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p2-dff(xx)).^2);
    title(['3-punktowy: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
    
    % 3-punktowy
    subplot(2,3,i+3)
    hold on
    plot(xx, f(xx),'k')
    plot(xx,dff(xx), 'r')
    %
    p3 = pochodna_z3(f,a,b,h(i),5); 
    plot(xx,p3, 'b--')   % wykres pochodnej
    mse2 = 1/length(xx)*sum((p3-dff(xx)).^2);
    title(['5-punktowy: h = ', num2str(h(i)) ,' blad: ', num2str(mse2)])
       
end

end

function [p] = pochodna_z3(f,a,b,h,s)
    if s == 3 %trojpunktowy
        i = 1;
        for x = a:h:b                
           p(i) = (f(x+h)-2*f(x)+f(x-h))/(h.^2); 
           i = i + 1;
        end
    elseif s == 5 %pięciopunktowy
         i = 1;
        for x = a:h:b               
           p(i) = (-f(x+2*h)+16*f(x+h)-30*f(x)+16*f(x-h)-f(x-2*h))/(12*h.^2); 
           i = i + 1;
        end
    else
        p = NaN;
    end
end