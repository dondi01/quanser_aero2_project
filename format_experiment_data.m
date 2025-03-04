clearvars;
close all;
clc;
data = load("experiments_data\VOLTAGE-FORCE\SATURATION_ANGLE.mat");
data_transposed = transpose(data.data);
datatable = array2table(data_transposed,...
    'VariableNames',{'time','m0_voltage','m1_voltage', 'm0_current', 'm1_current', 'pitch', 'yaw', 'x_acc', 'z_acc', 'm0_speed', 'm1_speed'});




pitch = datatable.pitch;
%pitch_stable = pitch(4147:end);
m0_speed = datatable.m0_speed;
