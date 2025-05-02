function [state,omega_fan_dot]= yaw_step(state_old,V,Ts,fd,omega_real)

Jy=0.0238;
%C=0.0051079;
C=0.0061;
beta=0.0000037343;
fs=0.0088;

%fd=0.0029;
fd=0.0035;

gamma=0.0012417;
Dt=0.167;

omega_fan=omega_real;%state_old(1);
yaw_dot=state_old(2);
yaw=state_old(3);

%From the identified transfer function
omega_fan_dot=1/0.1699*(15.2861*V-gamma*omega_fan^2*sign(omega_fan)-omega_fan);

omega_fan_upd=omega_fan+Ts*omega_fan_dot;

attrito=abs(beta*(omega_fan^2*sign(omega_fan))*Dt - C*yaw_dot);

% if attrito>fs
%     attrito=max(fs+(fs-attrito)/(fs*2-fs)*(fs-fd),fd);
% end

 if attrito>fs || yaw_dot~=0
     attrito=fd;
 end

yaw_double_dot=1/Jy*( ...
    beta*(omega_fan_upd^2*sign(omega_fan_upd))*Dt ...
    -C*yaw_dot ...
    -attrito*sign(yaw_dot));
yaw_dot_upd=yaw_dot+Ts*yaw_double_dot;
yaw_upd=yaw+Ts*yaw_dot;

state=[omega_fan_upd,yaw_dot_upd,yaw_upd];

end