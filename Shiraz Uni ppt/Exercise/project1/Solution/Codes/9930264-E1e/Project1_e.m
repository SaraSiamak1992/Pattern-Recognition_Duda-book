clc
clear 
close all

font = 'Times New Roman';
%% 
a1=3;
a2=5;
b=1;
x=-4:0.01:12;
%% P(x|wi)
a=a1;
P_x_w1 = Cauchy_function(x, a, b);

a=a2;
P_x_w2 = Cauchy_function(x, a, b);

%% P(wi|x)   P(w1)=P(w2)
P_w1=0.5;
P_w2=0.5;

P_x=P_x_w1*P_w1+P_x_w2*P_w2;

P_w1_x=(P_x_w1.*P_w1)./P_x;
P_w2_x=(P_x_w2.*P_w2)./P_x;

Zone=zeros(size(x));
for i=1:size(x,2)
    P=x(i) ;
    if P<((a1+a2)/2)
        Zone(i)=1;
    elseif P>((a1+a2)/2)
        Zone(i)=2;
    end
end

%% Plot
h1=figure('DefaultAxesFontName', font);
axes;
p1=plot(x,P_w1_x,'linewidth',1.5);
hold on
p2=plot(x,P_w2_x,'linewidth',1.5);
hold on
for i=1:size(x,2)
    if Zone(i)==1
       SMPT1=x(i);
       DQ1=0;
       p3=plot(SMPT1,DQ1,'rs','linewidth',2,'MarkerSize',2);
    end
end

hold on

for i=1:size(x,2)
  if Zone(i)==2
       SMPT2=x(i);
       DQ2=0;
       p4=plot(SMPT2,DQ2,'bs','linewidth',2,'MarkerSize',2);
  end
end

y=0:0.1:1;
p5=plot(((a1+a2)/2)*ones(size(y,2)),y,'--' ,'linewidth',1);

grid on
xlabel('x','fontsize',16)
ylabel('P(w_i|x)','fontsize',16) 
legend([p1 p2 p3 p4],{'P(w_1|x)','P(w_2|x)','R_1(Region 1)','R_2(Region 2)'},'fontsize',12)
