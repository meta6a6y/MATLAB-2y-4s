clc
% Несобственный интеграл
syms a x
integral_result = int(a^x*exp(-x), x, 0, Inf);
disp(['Несобственный интеграл: ', char(integral_result)]);
% Неопределенный интеграл
syms p
integral_result2 = int((1+x)/((x+a)^(p+1)), x, 0, Inf);
disp(['Неопределенный интеграл: ', char(integral_result2)]);