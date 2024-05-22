clc
A = [1, 1, 1, -1; 
    2, -2, 4, 2;
    3, 1, 2, -2;
    2, 2, -3, 5];

F = [2; -2; -5; 3];

% ��� �������
fprintf('����������� �������: %.2f\n', det(A));
fprintf('���� �������: %.2f\n', rank(A));
fprintf('����� �������������: %.2f\n', norm(A));
fprintf('����� ���������������: %.2f\n', cond(A));

% ����� ������� ��������
e = 0.0001;
N = length(F);
fprintf('������� � ������� linsolve:');
fprintf('\t%.2f', linsolve(A, F));

u = [0; 0; 0; 0];
u1 = u;
k = 0.01;
A1 = eye(N) - k * (A' * A);
F1 = k * (A' * F);
eig(A1);
step = 1;
while true
    u1 = A1 * u + F1;
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
accuracy = norm(A * u - F);


fprintf('\n���������� �������� i = %d\n', step);
fprintf('������ �������:');
fprintf('\t%.2f\t', u);

x1 = inv(A) * F;
check1 = x1 - u;
fprintf('\n\n��������:');
fprintf('\t%.4f\t', check1);

check2 = linsolve(A, F) - u;
fprintf('\n\n�������� �� linsolve:');
fprintf('\t%.4f\t', check2);

