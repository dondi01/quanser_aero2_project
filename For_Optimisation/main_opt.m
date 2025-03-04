clear
load Test_data\VOLTAGE-FORCE\NO_WEIGHTS_4V.mat

t=data(1,:)';
t=linspace(0,length(t)*0.002,length(t))';
V=[t,data(2,:)'];
I=data(4,:)';
Omega=[t,data(10,:)'];

options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType',...
    'central');

A=-[1  0  0;
  -1  0  0;
   0  1  0;
   0 -1  0;
   0  0  1;
   0  0 -1];

tol=0.2;
name=@(params)machine(params,I);
b=-[8.4-tol; -(8.4+tol); (1.16-0.2)*1e-3;-(1.16+0.2)*1e-3; (4.2-0.2)*1e-2;-(4.2+0.2)*1e-2];
fin_params=fmincon(name,[8.40,1.16*1e-3,4.2*1e-2]',A,b,[],[],[],[],[],options);
