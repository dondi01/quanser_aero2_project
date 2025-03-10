clear
load ..\experiments_data\VOLTAGE-SPEED\Voltage2SpeedFromZero.mat

%data=data(:,1:124588);
t=data(1,:)';
t=linspace(0,length(t)*0.002,length(t))';
V=[t,data(2,:)'];
I=data(4,:)';
Omega=[t,data(10,:)'];

options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType',...
    'central');

%% Force model
handle=@(params)fan(params,I);
%x=[k1,k2,mu,gamma,K_i]
A=[0,0,1,0,0;
   0,0,-1,0,0;
   0,0,0,1,0;
   0,0,0,-1,0
   0,0,0,0,1;
   0,0,0,0,-1];
b=[10;0;1e-3;0;1e-1;0];

fin=fmincon(handle,[19.0,0.165,1,1e-6,0.042],A,b,[],[],[],[],[],options);

%% Machine model 
options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType',...
    'central');

tol=0.5;

%x=[R,L,Ko,e,Kv,Voff]
A= [-1   0   0  0    0  0;
     1   0   0  0    0  0;
     0  -1  0  0     0  0;
     0   1   0  0    0  0;
     0   0  -1  0    0  0;
     0   0   1  0    0  0;
     0   0   0  0   -1  0;
     0   0   0  1    0  0;
     0   0   0 -1    0  0];

b=[-(8.4-tol); 8.4+tol; -(1.16-tol)*1e-3;(1.16+tol)*1e-3;-(4.2-tol)*1e-2;(4.2+tol)*1e-1;0;1;0];

 % A=[-1,0,0;0,-1,0;1,0,0;0,1,0];
 % b=[0;0;1e-1;1];

name=@(params)machine(params,I);

fin_params=fmincon(name,[8.6688,0.0014463,0.041327,0.0041229,0.6799,-0.096188]',A,b,[],[],[],[],[],options);
