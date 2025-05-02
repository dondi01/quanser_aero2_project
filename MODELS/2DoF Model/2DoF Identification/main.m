clear
close
load('..\2_DOF.mat');

t = data(1,:);
yawreal = data(7,:)';
speed0 = [t; data(10,:)]';
speed1 = [t; data(11,:)]';
pitch = [t; data(6,:)]';
yaw = [t; data(7,:)]';
pitch_der = derivate_better(data(6,:));
pitch_d = [t; pitch_der]';

load('2dof_parameters.mat');

options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType','central');

handle=@(params)opt2dof(params,yawreal);

open("..\dynamical_model.slx");

A = [];
b = [];

fin = fmincon(handle,[0, 0],A,b,[],[],[],[],[],options);

cpos = fin(1)
cneg = fin(2)