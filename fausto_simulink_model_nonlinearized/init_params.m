clearvars;
close all;
clc;

Dm = 0.00240;
Dt = 0.167;

Md = 1.07;
g = 9.81;


Jp = 1;
Jr = 4.00e-6;
Jyaw = 1;
Jz = 1;

C = 1;
Cr = 1;

%% electric motor

Rm = 8.40;
kt = 4.20e-2;
ke = kt;
Jr = 4.00e-6;
Jh = 3.04e-8;
Jprop = 4.00e-5;
Jeq = Jr + Jh + Jprop;
gamma = 0;
beta = 1;


%% TEST DATA IMPORT

data = load("test_datatable.mat");

m0_voltage_in(:, 1) = data.datatable(:, 1);
m1_voltage_in(:, 1) = data.datatable(:, 1); 
pitch_meas(:,1) = data.datatable(:, 1); 
yaw_meas(:,1) = data.datatable(:, 1); 

m0_voltage_in(:, 2) = data.datatable(:, 2);
m1_voltage_in(:, 2) = data.datatable(:, 3); 
pitch_meas(:,2) = data.datatable(:, 6); 
yaw_meas(:,2) = data.datatable(:, 7); 