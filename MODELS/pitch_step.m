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
pitch_dot=state_old(2);
pitch=state_old(3);

%From the identified transfer function
omega_fan_dot=1/0.1699*(15.2861*V-gamma*omega_fan^2*sign(omega_fan)-omega_fan);

omega_fan_upd=omega_fan+Ts*omega_fan_dot;

%psi_acc=1/Jp*(M0-M1-C*psi_dot-Mb*g*sin(theta)*dm), then integrated
psi_double_dot=1/Jp*( ...
    beta*(omega_fan_upd^2*sign(omega_fan_upd))*Dt*2 ...
    -C*pitch_dot ...
    -Mb*g*Dm*sin(pitch));
pitch_dot_upd=pitch_dot+Ts*psi_double_dot;
pitch_upd=pitch+Ts*pitch_dot;

state=[omega_fan_upd,pitch_dot_upd,pitch_upd];

end