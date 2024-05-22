clc
% метод ЗЕЙДЕЛЯ
A0 = [1, 1, 1, -1; 
    2, -2, 4, 2; 
    2, 2, -3, 5; 
    3, 1, 2, -2];

F0 = [2; -2; 3; -5];
e = 0.001;
 
fprintf('Решение с помощью linsolve:');
fprintf('\t%.2f\t', linsolve(A, F));
% добавить нормализацию
F = A0' * F0;
A = A0' * A0;

V = diag(A);
D = diag(V);
LL = tril(A);
L = LL - D;
UU = triu(A);
U = UU - D;

u = [0; 0; 0; 0];
u1 = u;

step = 1;
while true
    u1 = -(L+D)\U*u+(L+D)\F;
    if abs(norm(u1) - norm(u)) <= e
        break;
    end
    u = u1;
    step = step + 1;
    if (step >10000)
        break;
    end
end
u = u1;

fprintf('\nКоличество итераций i = %d\n',step);
fprintf('Вектор решений:');
fprintf('\t%.2f\t', u);

x1 = inv(A0) * F0;
check1 = x1 - u;
fprintf('\n\nПроверка:');
fprintf('\t%.4f\t', check1);

check2 = linsolve(A0, F0) - u;
fprintf('\n\nПроверка по linsolve:');
fprintf('\t%.4f\t', check2);

