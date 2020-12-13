clc
clear 
close all

font = 'Times New Roman';
addpath('Tiny_MNIST_Dataset')
load('MNIST_data')

Train_data=TrainData;
Train_label=Trainlabels;
Test_data=TestData;
Test_label=Testlabels;

%% Train Part
%% Class
% P(wj|D)
omega=zeros(10,1);
for i=1:size(Train_label,1)
    for j=1:10
       if Train_label(i)==j-1
           omega(j)=omega(j)+1;
       end
    end
end
    
P_w=omega/size(Train_label,1);
sum_P_w=sum(P_w);

% Separating the data
Di=zeros(10,size(Train_label,1));
for i=1:size(Train_label,1)
    for j=1:10
       if Train_label(i)==j-1
        Di(j,i)=i;
       end
    end
end
D0=[]; D1=[];D2=[];D3=[];D4=[];
D5=[];D6=[];D7=[];D8=[];D9=[];

for i=1:size(Train_label,1)
   for j=1:10
    if Di(j,i)~=0 
        if j==1
           D0=[D0;Train_data(i,:)];
        elseif j==2
           D1=[D1;Train_data(i,:)];
        elseif j==3
           D2=[D2;Train_data(i,:)];
        elseif j==4
           D3=[D3;Train_data(i,:)];
        elseif j==5
           D4=[D4;Train_data(i,:)];
        elseif j==6
           D5=[D5;Train_data(i,:)];
        elseif j==7
           D6=[D6;Train_data(i,:)];
        elseif j==8
           D7=[D7;Train_data(i,:)];
        elseif j==9
           D8=[D8;Train_data(i,:)];
        elseif j==10
           D9=[D9;Train_data(i,:)];
        end
    end
   end
end

Ttotal=size(D0,1)+size(D1,1)+size(D2,1)+size(D3,1)+size(D4,1)+...
size(D5,1)+size(D6,1)+size(D7,1)+size(D8,1)+size(D9,1);
  D{1}=D0;D{2}=D1;D{3}=D2;D{4}=D3;D{5}=D4;D{6}=D5;D{7}=D6;D{8}=D7;D{9}=D8;D{10}=D9;         
%% mean
for p=1:10
    mu0=zeros(62,1);
    for i=1:size(D{p},1)
            x=D{p}(i,:)';
            mu0=mu0+ x;
    end
    MU{p}=mu0/size(D{p},1); 
end

%% Covariance
for p=1:10
    n=size(D{p},1);
    sum0=zeros(62,62);
    
    for i=1:n
         x= (D{p}(i,:))';
         sum0=sum0+(x-MU{p})*(x-MU{p})';
    end
COV{p}=(1/n)*sum0;
end

for i=1:10
    det(COV{i}) 
end

sigma_p=zeros(62,62);
for i=1:10
   sigma_p=sigma_p+(size(D{i},1))*COV{i};
end
COV{2}=(1/(5000-10))*sigma_p;
%% Test Data
d=size(Test_data,2);
for i=1:size(Test_data,1)
    
    x=(Test_data(i,:))';
    for j=1:10
        sigma=COV{j};
        mu=MU{j};
        Px_w(j)=Gaussian_Distribution(x,mu,sigma,d);
       
        a(j)=Px_w(j)*P_w(j);
    end
    
    b=max(a);
    class(i,1)=find(a==b)-1;   
end
%% Validation

omega_test=zeros(10,1);
for i=1:size(Test_label,1)
    for j=1:10
       if Test_label(i)==j-1
           omega_test(j)=omega_test(j)+1;
       end
       
    end
end
    
P_w_test=omega_test/size(Test_label,1);

Conf=zeros(10,10);
for i=1:size(Test_data,1)
  
    if Test_label(i)==class(i)
       
       j=Test_label(i)+1;
       Conf(j,j)= Conf(j,j)+1;
    else
        
       Conf(class(i)+1,Test_label(i)+1)= Conf(class(i)+1,Test_label(i)+1)+1;
        
    end 
  
end
for i=1:10
WW(i)=sum(Conf(i,:));
end


for i=1:10
    Accuracy(i)=(Conf(i,i)/omega_test(i))*100;
    
    error(i)=100-Accuracy(i);
end
Total_error=sum(error)/10;
%% plot
h1=figure('DefaultAxesFontName', font);
axes;
Xc=1:10;
bar(Xc,Accuracy)
grid on
xlabel('Class Number','fontsize',14)
ylabel('Recognition Percentage','fontsize',14)

h2=figure('DefaultAxesFontName', font);
axes;
Xc=1:10;
bar(Xc,error)
grid on
xlabel('Class Number','fontsize',14)
ylabel('Error Percentage','fontsize',14)
