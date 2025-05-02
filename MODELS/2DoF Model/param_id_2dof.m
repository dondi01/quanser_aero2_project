clear all
close all

load('datasheet_parameters.mat')

Jeq = Jr + Jh + Jprop;
beta = kt^2/Rm;

load('motor_parameters.mat')
% Identified Motor Parameters
gamma1 = opt_parameters(3);
gamma2 = opt_parameters(4);
mu = opt_parameters(1)/(1+opt_parameters(1)*gamma2);
tau = opt_parameters(2)/(1+opt_parameters(1)*gamma2);

% Motor PI Controller
I = 1/mu*100;
P = tau*I;

load('force_parameters.mat')

% values from identification
load('torque_coef_opt.mat')
cpos = cQp;
cneg = cneg;

% cpos = 3e-07;
% cneg = 0.5e-07;

% values by trial and error
% cpos = 3e-07;
% cneg = 0.5e-07;

force_coef = [kTp1, kTp2, kTn1, kTn2]; % , cpos, cpos, cneg, cneg];

% Inertia of lower body w.r.t. its local reference frame.
Jx1 = 0; % same as below
Jy1 = 0; % This could be set = 0 as it's not in the dynamical equations so do what you want.
Jz1 = Jy - Jp; %1.4e-03; % 0.0001052

% Inertial of upper body w.r.t its local reference frame.
Jx2 = Jz1; %0.0104; %4.5123e-04; % As first approximation, the inertia is euqal to the yaw body yaw axis
Jy2 = Jp; %0.03; %0.0699; % pitch yaw
Jz2 = Jy2; %0.1982; %0.2471; % Assumed it's equal to the pitch yaw cilindro assumption

% Damping due to pitch rotation (whole structure)
beta_pitch = 0.001763;  %0.001763  from 1dof
% load('..\pitch_parameters.mat')

% Damping due to yaw rotation (whole structure)
beta_yaw = 0.0051079; % from 1dof identification % 0.0244;

% Friction
fs = 0.0088; % threshold
fd = 0.0029; % constant force when moving

% load('..\yaw_parameters.mat')

mode = 2; % 0 for 1DoF Pitch; 1 for 1DoF Yaw; 2 for 2DoF

load('2_DOF.mat');

t = data(1,:);
voltage0 = [t; data(2,:)]';
voltage1 = [t; data(3,:)]';
current0 = [t; data(4,:)]';
current1 = [t; data(5,:)]';
pitch = [t; data(6,:)]';
yaw = [t; data(7,:)]';
x_acc = [t; data(8,:)]';
y_acc = [t; data(9,:)]';
speed0 = [t; data(10,:)]';
speed1 = [t; data(11,:)]';
pitch_ref = [t; data(12,:)]';
pitch_der = derivate_better(data(6,:));
pitch_d = [t; pitch_der]';
yaw_der = derivate_better(data(7,:));
yaw_d = [t; yaw_der]';

parameters = [Jx1, Jy1, Jz1, Jx2, Jy2, Jz2, beta_pitch, beta_yaw, fs, fd, mode];

load('pitch_cont_parameters.mat')