t=data(1,:)';
V=[t,data(2,:)'];
I=[t,data(4,:)'];
Omega=[t,data(10,:)'];

figure
I_sim=sim('machine_model');
plot(I_sim.yout{1}.Values.Data)
hold on
plot(I(:,2))
hold off