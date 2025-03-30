clear

beta=0.0000037343;
c=0.001763;
d2=0.167;
Jp=0.0232;
tau_ol=Jp/c;
mult_fact=1;

mu=c/(d2*beta)/10;

s=tf('s');
C=mu*(1+10*s)*(1+tau_ol*s)/s/(1+0.05*s)*mult_fact;
S=d2*beta/c/s/(tau_ol*s+1);

%fc=feedback(C*S,1);
%pzplot(fc)
%bode(C*S)

PI=(0.16199*s+1)/s/15.2861*mult_fact*100;
PI_Sat=(1-PI/PI);