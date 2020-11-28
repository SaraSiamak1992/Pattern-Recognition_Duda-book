clc
clear 
close all

font = 'Times New Roman';
%% 
a1=3;
a2=5;
b=1;
x=-4:0.1:12;
%% P(x|wi)
a=a1;
P_x_w1 = Cauchy_function(x, a, b);

a=a2;
P_x_w2 = Cauchy_function(x, a, b);
%% P(wi|x)   P(w1)=P(w2)
P_w1=0.5;
P_w2=0.5;

P_x=sum(P_x_w1*P_w1+P_x_w2*P_w2);

P_w1_x=P_x_w1*P_w1./P_x;
P_w2_x=P_x_w2*P_w2./P_x;
%% Plot
h1=figure('DefaultAxesFontName', font);
axes;
plot(x,P_w1_x,'linewidth',1.5)
hold on
plot(x,P_w2_x,'linewidth',1.5)
grid on

xlabel('x','fontsize',16)
ylabel('P(w_i|x)','fontsize',16) 
legend('P(w_1|x)','P(w_2|x)','fontsize',12)

