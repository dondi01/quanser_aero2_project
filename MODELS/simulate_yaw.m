function [yaw_error,yaw,yaw_dot] = simulate_yaw(Ts,cur_state,V,real_yaw,real_yaw_dot,C,omega_real)

len=length(V);
yaw=zeros(len+1,1);
omega=zeros(len+1,1);
yaw_dot=zeros(len+1,1);

yaw(1)=cur_state(3);
omega(1)=cur_state(1);
yaw_dot(1)=cur_state(2);

for i=2:len+1
    cur_state=yaw_step(cur_state,V(i-1),Ts,C,omega_real(i-1));
    yaw(i)=cur_state(3);
    omega(i)=cur_state(1);
    yaw_dot(i)=cur_state(2);
end
yaw=yaw(2:end);
yaw_dot=yaw_dot(2:end);
%plot(pitch)
%pitch_error=sum((pitch(1:end)-setpoint).^2*(1+var(V)));
yaw_error=sum(...
    ((yaw_dot-real_yaw_dot)).^2 +...
    ((yaw-real_yaw)/1000).^2 ...
    );
