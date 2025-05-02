clear
close

run('..\param_id_2dof.m');

load('..\..\Data\2_DOF.mat');

t = data(1,:);
yawreal = data(7,:)';
speed0 = [t; data(10,:)]';
speed1 = [t; data(11,:)]';
pitch = [t; data(6,:)]';
yaw = [t; data(7,:)]';
pitch_ref = [t; data(12,:)]';
pitch_der = derivate_better(data(6,:));
pitch_d = [t; pitch_der]';

options=optimoptions('fmincon','Display','iter-detailed','FiniteDifferenceType','central');

handle=@(params)opt2dof(params,yawreal);

open("..\dynamical_model.slx");

A = [];
b = [];

fin = fmincon(handle,[0],A,b,[],[],[],[],[],options);

cneg = fin(1)