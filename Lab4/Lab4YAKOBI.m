clc
% метод ЯКОБИ
A0 = [1, 1, 1, -1; 
    2, -2, 4, 2; 
    2, 2, -3, 5; 
    3, 1, 2, -2];

F0 = [2; -2; 3; -5];
E = 0.001;
% добавить нормализацию
F = A0' * F0;
A = A0' * A0;

fprintf('Решение с помощью linsolve:');
fprintf('\t%.2f\t', linsolve(A, F));
V = diag(A);
D = diag(V);
LL = tril(A);
L = LL - D;
UU = triu(A);
U = UU - D;

B = -(L + D)^-1 * U;
F = (L + D)^-1 * F;

%fprintf('\nНорма B: %.4f\n', norm(B));

u = [0; 0; 0; 0];
u1 = B * u + F;
step = 0;
while (abs(max(u) - max(u1)) >= E)
    u = u1;
    u1 = B * u + F;
    step = step + 1;
    if (step >1000)
        break;
    end
end
u = u1;

fprintf('\nКоличество итераций i = %d\n', step);
fprintf('Вектор решений:');
fprintf('\t%.2f\t',u); 

x1 = inv(A0) * F0;
check1 = x1 - u;
fprintf('\n\nПроверка:');
fprintf('\t%.4f\t', check1);

check2 = linsolve(A0, F0) - u;
fprintf('\n\nПроверка по linsolve:');
fprintf('\t%.4f\t', check2);

