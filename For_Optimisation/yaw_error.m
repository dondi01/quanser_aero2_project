function err = yaw_error(params,yaw_meas)
c=params(1);
fs=params(2);
%Jy=params(3);

set_param("AL_model_YAW/SYSTEM/C","Gain",string(c));
%set_param("AL_model_YAW/SYSTEM/Jy","Gain",string(1/Jy));
set_param("AL_model_YAW/SYSTEM/fs","Gain",string(fs));

try
    data=sim("AL_model_YAW.slx");
    err=mean((data.yout{1}.Values.Data-yaw_meas).^2);
catch
    err=1e20;
end

end