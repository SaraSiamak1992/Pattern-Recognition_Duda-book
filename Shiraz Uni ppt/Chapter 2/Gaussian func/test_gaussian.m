%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x= data to be plotted
% s= standard deviation
% mu= mean
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 
close all
font = 'Times New Roman';
%%
a = -100; b = 100;
x = a + (b-a) * rand(1, 500);
mu = (a + b)/2;
s = 30; 
f = gaussian_function(x, mu, s);
plot(x,f,'.')
grid on
title('Bell Curve')
xlabel('Randomly produced numbers')
ylabel('Gauss Distribution') 
%% Optimal Decision
a = -2; b = 6;
x = a:0.01:b;
mu = 2;
s = 0.5; 
P_x_w1 = gaussian_function(x, mu, s);
mu = 1.5;
s = 0.2; 
P_x_w2 = gaussian_function(x, mu, s);

h1=figure('DefaultAxesFontName', font);
axes;
plot(x,P_x_w1,'linewidth',1.5)
hold on
plot(x,P_x_w2,'linewidth',1.5)
grid on
xlabel('x','fontsize',12)
ylabel('P(x|w_i)','fontsize',12) 
legend('P(x|w_1)','P(x|w_2)','fontsize',12)

B=zeros(size(x));
for i=1:size(x,2)
    P=P_x_w1(i)/P_x_w2(i) ;
    if P>(3/8)
    B(i)=1;
    else
    B(i)=2;
        
    end
end
h2=figure('DefaultAxesFontName', font);
for i=1:size(x,2)
    if B(i)==1
        plot(x(i),B(i),'r.'),grid
    end
    hold on
    if B(i)==2
        plot(x(i),B(i),'b.'),grid 
    end
    hold on
end

