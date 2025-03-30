%clear
%close

load('..\experiments_data\VOLTAGE-FORCE\NO_WEIGHTS_FULL.mat')
data_nw = data(:,find(data(1,:)==15):find(data(1,:)==920));
load('..\experiments_data\VOLTAGE-FORCE\11_74_WEIGHTS_FULL.mat')
data_w = data(:,find(data(1,:)==75):find(data(1,:)==830));
data = [data_nw data_w];

Mb = 1.07;
Dt = 0.167;
Dm = 0.00240;
Jp = 0.0232;
g = 9.81;
m=11.74e-3;

omega=data(10,:);
pitch=data(6,:)-min(data(6,:));
v=data(2,:);

y=((Mb*g*sin(pitch)*Dm+m*g*cos(pitch).*(v>=15)*Dt)/Dt)';


A=[omega',omega'.^2];

params=(A'*A)^-1*A'*y;
figure
plot(A*params)
hold on
plot(y)
hold off
