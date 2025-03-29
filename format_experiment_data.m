clearvars;
close all;
clc;
exp_0 = format_into_datatable("C:\git\quanser_aero2_project\experiments_data\VOLTAGE-FORCE\WEIGHTED_35_76_zero_M0.mat");
exp_1 = format_into_datatable("C:\git\quanser_aero2_project\experiments_data\SATURATION-ANGLE\SATURATION_ANGLE.mat");
exp_2 = format_into_datatable("C:\git\quanser_aero2_project\experiments_data\VOLTAGE-FORCE\WEIGHT_11_74_16V.mat");

function datatable = format_into_datatable(data_address)
    data = load(data_address);
    data_transposed = transpose(data.data);
    datatable = array2table(data_transposed,...
        'VariableNames',{'time','m0_voltage','m1_voltage', 'm0_current', 'm1_current', 'pitch', 'yaw', 'x_acc', 'z_acc', 'm0_speed', 'm1_speed'});
end

pitch_0 = exp_0.pitch;
pitch_1 = exp_1.pitch;
pitch_2 = exp_2.pitch;
%pitch_stable = pitch(4147:end);

