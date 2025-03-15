function err = fan(params,Omega)
 mu=params(1);
 gamma=params(2);
%ratio=params(3);
%pole=params(1);

% k1=params(1);
% k2=params(2);
% mu=params(3); 
% gamma=params(4);
% K_I=params(5);

%den = ['[', num2str(pole), ' ', num2str(1), ']'];  
%set_param('V_S/Omega_tf', 'Denominator', den);
set_param('V_S/Omega_tf', 'Numerator', string(mu));
set_param("V_S/gamma", 'gain',string(gamma));
%set_param("V_S/R_K", 'gain',string(ratio));

try
    Omega_sim=sim("V_S");
    err=mean((Omega_sim.yout{1}.Values.Data-Omega).^2);
catch
    err=1e10;
end

end