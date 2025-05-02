function [err, pitch]= pitch_err(params,pitch_meas)

c=params(1);
%fs=params(2);

set_param("AL_model_PITCH/C","Gain",string(c));
%set_param("AL_model_PITCH/fs","UpperLimit",string(fs));
%set_param("AL_model_PITCH/fs","LowerLimit",string(-fs));
try
    data=sim("AL_model_PITCH.slx");
    err=mean((data.yout{1}.Values.Data-pitch_meas).^2);
    pitch=data.yout{1}.Values.Data;
catch
    err=1e20;
end

end