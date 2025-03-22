function err = machine(params,I_meas)
%Kv=params(1);
%Voff=params(2);
%e=params(3);

R=params(1);
L=params(2);
Ko=params(3);
square=params(4);
Kv=params(5);
Voff=params(6);

% set_param("machine_model/R", 'Value',string(R));
% set_param("machine_model/L", 'Value',string(L));
% set_param("machine_model/Ko", 'Gain',string(Ko));
% set_param("machine_model/Kv", 'Gain',string(Kv));
% set_param("machine_model/Voff", 'Value',string(Voff));
% set_param("machine_model/square", 'Gain',string(square));

I=sim("machine_model");
err=sum((I.yout{1}.Values.Data-I_meas).^2);

end