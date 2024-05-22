clc
clear all
% ������
temperature = [-55, -50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
density = [15.52067251, 14.91564578, 14.22407091, 11.92569264, 10.07157314, 8.835262003, 7.934693368, ...
           7.237676594, 6.674205242, 6.203634867, 5.800662255, 5.448664316, 5.1362575, 4.855399675, ...
           4.600288192, 4.366697228, 4.151059958, 3.950151872, 3.77597404, 3.622773726, 3.486430024];
weight_coeff = [0.3, 0.1, 0.5, 0.2, 1.0, 0.4, 0.3, 1.0, 0.1, 0.1, 0.7, 0.2, 1.0, 0.6, 0.3, 0.5, 0.1, 0.7, 0.2, 0.2, 0.1];

% �������-�������� ������������
interp_density = interp1(temperature, density, 'linear');
interp_weight_coeff = interp1(temperature, weight_coeff, 'linear');

% ���������� �������� � �������� ����������
mid_temp1 = (temperature(13) + temperature(14)) / 2;
mid_temp2 = (temperature(14) + temperature(15)) / 2;
interp_density_mid1 = interp1(temperature, density, mid_temp1, 'linear');
interp_density_mid2 = interp1(temperature, density, mid_temp2, 'linear');
interp_weight_coeff_mid1 = interp1(temperature, weight_coeff, mid_temp1, 'linear');
interp_weight_coeff_mid2 = interp1(temperature, weight_coeff, mid_temp2, 'linear');

% ������ ������� �������� � ������� ���������� ���������
degree = length(temperature) - 1;

disp(['������� �������� (���������� ��������): ', num2str(degree)]);

% ����������
disp(['����������������� �������� ��������� ��� T = ', num2str(mid_temp1), ': ', num2str(interp_density_mid1)]);
disp(['����������������� �������� ��������� ��� T = ', num2str(mid_temp2), ': ', num2str(interp_density_mid2)]);
disp(['����������������� �������� �������� ������������ ��� T = ', num2str(mid_temp1), ': ', num2str(interp_weight_coeff_mid1)]);
disp(['����������������� �������� �������� ������������ ��� T = ', num2str(mid_temp2), ': ', num2str(interp_weight_coeff_mid2)]);

% ������ ����������� ������������
error1 = abs(interp_density_mid1 - density(14));
error2 = abs(interp_density_mid2 - density(15));
disp(['����������� ������������ ��������� ��� T = ', num2str(mid_temp1), ': ', num2str(error1)]);
disp(['����������� ������������ ��������� ��� T = ', num2str(mid_temp2), ': ', num2str(error2)]);

% ������
figure;
plot(temperature, density, 'bo', 'DisplayName', '����������������� �����');
hold on;
plot(temperature, interp_density, 'r-', 'DisplayName', '����������������� ���������', 'Marker', 'o');
xlabel('����������� (C)');
ylabel('�������� ��������� (kgmole/m3)');
legend;
title('������������ �������� ��������� �� �����������');
grid on;
