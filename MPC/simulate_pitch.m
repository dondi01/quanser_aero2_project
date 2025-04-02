function [pitch_error,pitch] = simulate_pitch(Ts,cur_state,V,setpoint)

len=length(V);
pitch=zeros(len+1,1);
psi_dot=zeros(len+1,1);

pitch(1)=cur_state(3);
psi_dot(1)=cur_state(2);

for i=2:len+1
    cur_state=pitch_step(cur_state,V(i-1),Ts);
    pitch(i)=cur_state(3);
    psi_dot(i)=cur_state(2);
end
%plot(pitch)
pitch_error=sum((pitch(2:end)-setpoint).^2+ var(V)/(abs(max(V))+(max(V)==0)));
