clc
clear 
close all

font = 'Times New Roman';
%% 
Landa=[0 1;2 0];
a1=3;
a2=5;
b=1;
x=-4:0.1:12;
%% P(x|wi)
a=a1;
P_x_w1 = Cauchy_function(x, a, b);

a=a2;
P_x_w2 = Cauchy_function(x, a, b);
%% P(wi|x)   
P_w1=0.5;
P_w2=0.5;

P_x=sum(P_x_w1*P_w1+P_x_w2*P_w2);

P_w1_x=P_x_w1*P_w1./P_x;
P_w2_x=P_x_w2*P_w2./P_x;

Alpha=P_w1_x./P_w2_x;

Time_Zone=zeros(size(x));
for i=1:size(x,2)
    P=Alpha(i) ;
    if P>((Landa(1,2)-Landa(2,2))/(Landa(2,1)-Landa(1,1)))*(P_w2/P_w1)
        Time_Zone(i)=1;
    else
        Time_Zone(i)=2;
    end
end

%% Plot
h1=figure('DefaultAxesFontName', font);
axes;
p1=plot(x,Alpha,'linewidth',1.5);
hold on

p2=plot(x,(((Landa(1,2)-Landa(2,2))/(Landa(2,1)-Landa(1,1)))*(P_w2/P_w1))*ones(size(x)),'--','linewidth',1);
hold on

for i=1:size(x,2)
    if Time_Zone(i)==1
       SMPT1=x(i);
       DQ1=0;
       p3=plot(SMPT1,DQ1,'rs','linewidth',2,'MarkerSize',2);
    end
end

hold on

for i=1:size(x,2)
  if Time_Zone(i)==2
       SMPT2=x(i);
       DQ2=0;
       p4=plot(SMPT2,DQ2,'bs','linewidth',2,'MarkerSize',2);
  end
end

grid on
xlabel('x','fontsize',16)
ylabel('P(x|w_1)/P(x|w_2)','fontsize',16)

legend([p1 p2 p3 p4],{'P(x|w_1)/P(x|w_2)','\theta_1','R_1(Region 1)','R_2(Region 2)'},'fontsize',12)

