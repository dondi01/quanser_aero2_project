function [state,omega_fan_dot]= pitch_step_lin(state_old,V,Ts,setpoint,t)

Mb = 1.07;
Dm = 0.00240;
Jp = 0.0232;
g = 9.81;
Dt = 0.167;
C=0.001763;
beta=0.0000037343;
gamma=0.0012417;

omega_fan0=state_old(1);
omega_fan1=state_old(2);
pitch_dot=state_old(3);
pitch=state_old(4);
err=state_old(5);

%From the identified transfer function
omega_fan_dot0=1/0.1699*(15.2861*V-gamma*omega_fan0^2*sign(omega_fan0)-omega_fan0);
V1=-V;
omega_fan_dot1=1/0.1699*(15.2861*V1-gamma*omega_fan1^2*sign(omega_fan1)-omega_fan1);

omega_fan_upd0=omega_fan0+Ts*omega_fan_dot0;
omega_fan_upd1=omega_fan1+Ts*omega_fan_dot1;

%psi_acc=1/Jp*(M0-M1-C*psi_dot-Mb*g*sin(theta)*dm), then integrated
psi_double_dot=1/Jp*( ...
    beta*(omega_fan_upd0^2*sign(omega_fan_upd0)-omega_fan_upd1^2*sign(omega_fan_upd1))*Dt ...
    -C*pitch_dot ...
    -Mb*g*Dm*sin(setpoint)...
    -Mb*g*Dm*cos(setpoint)*(pitch-setpoint));

pitch_dot_upd=pitch_dot+Ts*psi_double_dot;
pitch_upd=pitch+Ts*pitch_dot;
err_upd=err+t*Ts*(setpoint-pitch_upd);


state=[omega_fan_upd0,omega_fan_upd1,pitch_dot_upd,pitch_upd,err_upd];

end