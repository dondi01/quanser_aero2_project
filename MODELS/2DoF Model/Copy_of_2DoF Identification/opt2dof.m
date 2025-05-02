function err = opt2dof(params,yawreal)

% cpos = params(1);
cneg = params(1);

% set_param("dynamical_model/2DoF System/cpos", 'Value', string(cpos));
set_param("dynamical_model/2DoF System/cneg", 'Value', string(cneg));

try
    yaw=sim("dynamical_model");
    err=sum((yaw.yout{1}.Values.Data-yawreal).^2);
catch
    err=inf;
end

end