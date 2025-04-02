function [pitch_error,pitch] = simulate_pitch(Ts,cur_state,omega,setpoint)

len=length(omega);
pitch=zeros(len+1,1);
pitch_dot=zeros(len+1,1);

pitch(1)=cur_state(2);
pitch_dot(1)=cur_state(1);

for i=2:len+1
    cur_state=pitch_step(cur_state,omega(i-1),Ts);
    pitch(i)=cur_state(2);
    pitch_dot(i)=cur_state(1);
end

%plot(pitch)
pitch_error=sum((pitch(2:end)-setpoint).^2);
