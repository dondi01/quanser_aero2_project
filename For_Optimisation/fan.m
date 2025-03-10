function err = fan(params,I)
k1=params(1);
k2=params(2);
mu=params(3); 
gamma=params(4);
K_I=params(5);

den = ['[', num2str(k1), ' ', num2str(k2), ']'];  
set_param('V_S/Omega_tf', 'Denominator', den);
set_param('V_S/Omega_tf', 'Numerator', string(mu));
set_param("V_S/gamma", 'gain',string(gamma));
set_param("V_S/K_I", 'gain',string(1/K_I));

I_sim=sim("V_S");

err=sum((I_sim.yout{1}.Values.Data-I).^2);

end