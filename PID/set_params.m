clear

beta=0.0000037343;
c=0.001763;
d2=0.167;
Jp=0.0232;
tau_ol=Jp/c;
mult_factor=1;


tau_set=0.05/mult_factor;

mu=c/(d2*beta)/10;


s=tf('s');
C_position=mu*(1+10*s)*(1+tau_ol*s)/s/(1+tau_set*s)*mult_factor;
S=d2*beta/c/s/(tau_ol*s+1);

I_position=1000; %C_position.Numerator{:}(end);
P_position=C_position.Numerator{:}(2)-I_position*tau_set*40;
D_position=C_position.Numerator{:}(1)-P_position*tau_set*5;

PI_position=I_position/s+P_position+D_position*1/tau_set/(1+1/tau_set*1/s);

check_position=PI_position-C_position


%fc=feedback(C*S,1);
%pzplot(fc)
margin(PI_position*S)

mu_omega=15.2861;
C_omega=(0.16199*s+1)/s/15.2861*10;

I_omega=C_omega.Numerator{:}(end)/mu_omega;
P_omega=C_omega.Numerator{:}(1)/mu_omega;

PI_omega=I_omega/s+P_omega;

check_omega=PI_omega-C_omega
