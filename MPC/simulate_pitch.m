function [pitch_error,pitch] = simulate_pitch(Ts,cur_state,V,setpoint,setpoint_dot,params,t)

len=length(V);
pitch=zeros(len+1,1);
pitch_dot=zeros(len+1,1);
err=zeros(len+1,1);

pitch(1)=cur_state(4);
pitch_dot(1)=cur_state(3);
err(1)=cur_state(5);

for i=2:len+1
    cur_state=pitch_step(cur_state,V(i-1),Ts,setpoint,params(3)*(t+Ts*i)^2);
    pitch(i)=cur_state(4);
    pitch_dot(i)=cur_state(3);
    err(i)=cur_state(5);
end
%plot(pitch)
pitch_error=...
     params(4)*sum((pitch(1:end)-setpoint).^2)...
    +params(2)*sum((pitch_dot-setpoint_dot).^2)...
    +params(1)*sum(err.^2);...
    %+params(3)*var(V)/((max(V)==0)*1e-5+max(abs(V)));

