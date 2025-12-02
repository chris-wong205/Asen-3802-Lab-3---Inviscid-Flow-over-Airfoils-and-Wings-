clc, clear, close all;

%% 
cd_v_cl = readmatrix("NACA 0012 Cl vs Cd.csv");
cl_v_alpha = readmatrix("NACA 0012 Cl vs alpha.csv");

alpha = interp1(cl_v_alpha(:,2),cl_v_alpha(:,1), cd_v_cl(:,1));

figure()
plot(alpha,cd_v_cl(:,2));
xlabel('Angle of Attack (degrees)');
ylabel('Sectional Coefficient of Drag (cd)');
title('Sectional Drag Coefficient vs Angle of Attack');
grid on;

induced_drag = [alpha, cd_v_cl(:,2)];

