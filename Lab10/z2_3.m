clc
% ������������� ��������
syms a x
integral_result = int(a^x*exp(-x), x, 0, Inf);
disp(['������������� ��������: ', char(integral_result)]);
% �������������� ��������
syms p
integral_result2 = int((1+x)/((x+a)^(p+1)), x, 0, Inf);
disp(['�������������� ��������: ', char(integral_result2)]);