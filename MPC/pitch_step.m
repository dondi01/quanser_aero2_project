function [state,omega_fan_dot]= pitch_step(state_old,V,Ts)

Mb = 1.07;
Dm = 0.00240;
Jp = 0.0232;
g = 9.81;
Dt = 0.167;
C=0.001763;
beta=0.0000037343;
gamma=0.0012417;

omega_fan=state_old(1);
psi_dot=state_old(2);
psi=state_old(3);

%From the identified transfer function
omega_fan_dot=1/0.1699*(15.2861*V-gamma*omega_fan^2*sign(omega_fan)-omega_fan);

omega_fan_upd=omega_fan+Ts*omega_fan_dot;

%psi_acc=1/Jp*(M0-M1-C*psi_dot-Mb*g*sin(theta)*dm), then integrated
psi_double_dot=1/Jp*( ...
    beta*(omega_fan_upd^2*sign(omega_fan_upd))*Dt ...
    -C*psi_dot ...
    -Mb*g*Dm*sin(psi));
psi_dot_upd=psi_dot+Ts*psi_double_dot;
psi_upd=psi+Ts*psi_dot;

state=[omega_fan_upd,psi_dot_upd,psi_upd];

end