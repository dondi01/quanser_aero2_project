clearvars;
close all;
clc;

fit_4v = load("fitted_distributions\fit_weight_11_74_4v.mat");
fit_8v = load("fitted_distributions\fit_weight_11_74_8v.mat");
fit_12v = load("fitted_distributions\fit_weight_11_74_12v.mat");
fit_16v = load("fitted_distributions\fit_weight_11_74_16v.mat");

pitch =[fit_4v.fit_weight_11_74_4V.mu
       fit_8v.fit_weight_11_74_8v.mu  
       fit_12v.weight_11_74_12v.mu  
       fit_16v.weight_11_74_16v.mu  
];

pitch_deg = 360/2/pi*(pitch - ones(4,1)*(-1.71696765164942/2));

voltage = [4 8 12 16]';

plot(voltage,pitch)