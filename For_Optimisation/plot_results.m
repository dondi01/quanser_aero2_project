t=data(1,:)';
V=[t,data(2,:)'];
I=[t,data(4,:)'];
Omega=[t,data(10,:)'];

Vm=0.0041229*V(:,2).^2+0.6799*V(:,2)-0.096188;
figure
V_sim=sim('V_S.slx');
plot(data(1,:),V_sim.yout{1}.Values.Data)
hold on
plot_pretty('Time [s]','Voltage [V]',data(1,:),Omega(:,2))
hold off
legend('Simulated','Real')