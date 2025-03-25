clear
%load ..\experiments_data\VOLTAGE-SPEED\Voltage2SpeedFromZero.mat
load ..\experiments_data\DYNAMIC_YAW\DYNAMIC_YAW\YAW_DYNAMIC_11_24.mat

%data=data(:,1:124588);
t=data(1,:)';
V0=[t,data(2,:)'];
V1=[t,data(3,:)'];
I0=data(4,:)';
I1=data(5,:)';
Omega0=[t,data(10,:)'];
Omega1=[t,data(11,:)'];
yaw=[t,data(7,:)'];
yaw_dot=[t,derivate_better(data(7,:))'];
%AL_parameters;
options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType',...
    'central','StepTolerance',1e-15);
%% Force model
handle=@(params)yaw_error(params,yaw_dot(:,2));
par=fmincon(handle,par,[-1,0;0,-1],[0;0],[],[],[],[],[],options);

%% torque model least square
% A=V(:,2);
% y=Omega(:,2)-5.0082e-07*Omega(:,2).^2;
% 
%Vm=0.0041229*V(:,2).^2+0.6799*V(:,2)-0.096188;
% 
% LS_gains=(A'*A)^-1*A'*y;
% set_param('V_S/Omega_tf', 'Numerator', string(LS_gains(1)));
% set_param('V_S/gamma', 'Gain', string(LS_gains(2)));

handle=@(params)fan(params,Omega(:,2));
A=-1;
b=0;
open("V_S.slx")
%fin=fmincon(handle,0.16199,[],[],[],[],[],[],[],options);
fin=fmincon(handle,[14.1439,-3.8077e-06],[],[],[],[],[],[],[],options);

plot_results();


%% Force model fmincon
handle=@(params)fan(params,V(:,2));

%x=[k1,k2,mu,gamma,K_i]
% A=[0,0,1,0,0;
%    0,0,-1,0,0;
%    0,0,0,1,0;
%    0,0,0,-1,0
%    0,0,0,0,1;
%    0,0,0,0,-1];
% b=[10;0;1e-3;0;1e-1;0];

A=[-1 0;
    0,-1;
    1 0;
    0 1;
    max(Omega(:,2))^2 max(Omega(:,2))];

b=[0;0;1e-6;1e-6;24/200];

fin=fmincon(handle,[8*1e-8,1e-7],A,b,[],[],[],[],[],options);

%% Machine model 
% options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType',...
%     'central');
% 
% tol=0.5;
% 
% %x=[R,L,Ko,e,Kv,Voff]
% A= [-1   0   0  0    0  0;
%      1   0   0  0    0  0;
%      0  -1  0  0     0  0;
%      0   1   0  0    0  0;
%      0   0  -1  0    0  0;
%      0   0   1  0    0  0;
%      0   0   0  0   -1  0;
%      0   0   0  1    0  0;
%      0   0   0 -1    0  0];
% 
% b=[-(8.4-tol); 8.4+tol; -(1.16-tol)*1e-3;(1.16+tol)*1e-3;-(4.2-tol)*1e-2;(4.2+tol)*1e-1;0;1;0];
% 
%  % A=[-1,0,0;0,-1,0;1,0,0;0,1,0];
%  % b=[0;0;1e-1;1];
% 
% name=@(params)machine(params,I);
% 
% fin_params=fmincon(name,[8.6688,0.0014463,0.041327,0.0041229,0.6799,-0.096188]',A,b,[],[],[],[],[],options);
