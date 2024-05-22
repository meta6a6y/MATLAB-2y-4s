clc
% 2 * exp(-3 * x) - 3 * x + 2
% x = -1: 0.0001 : 1;
f = @(x) 2*exp(-3*x) - 3*x + 2;
df1 = @(x) -6 * exp(-3 * x) - 3;  % -6 * exp(-3 * x) - 3
df2 = @(x) 18 * exp(-3 * x);  % 18 * exp(-3 * x)

figure;
ezplot('2 * exp(-3 * x) - 3 * x + 2', [-1 2 -2 5]);
grid on;

% �������� �����������, ������������ ����������� �������
a = -4;
b = 4;

a1 = 0;
b1 = 1;

x0 = fzero('2 * exp(-3 * x) - 3 * x + 2', [a b]);
y0 = 4;
fprintf('������ ���������, ���������� �������� fzero x = %f', x0);

hold on;
plot(x0, 0, '*red', 0, y0, '*red');
xlabel('x'); ylabel('y'); legend('2 * exp(-3x) - 3 * x + 2', '������ ���������');
 
% ����� ����������� �������

eps = 0.001;
k = 0;
c = 0;
while abs(a-b) > eps
        c = (a+b) / 2;
        if ((f(c)*f(a))<0)
            b = c;
        else
            a = c;
        end
        k = k + 1;
end

fprintf('\n\n����� ����������� ������� � ��������� e = %.3f', eps);
fprintf('\n���������� ��������: %d', k);
fprintf('\n�������� ����������� ����� [%f; %f]', a, b);


% ����� ��������
h = 0.01;
x = 0;
k = 0;
while(f(x) * f(x+h)) > 0 && x < 1
    x = x + h;
    t = x + h;
    k = k + 1;
end

fprintf('\n\n����� �������� c ����� h = %.2f', h);
fprintf('\n���������� �������: %d', k);
fprintf('\n�������� ����������� ����� [%f; %f]', x, t);
 
% ����� ������� ��������
g = @(x) (2 * exp(-3*x) / 3) + (x / 3);
x0 = 0;
x1 = g(x0);
eps = 0.1;
k = 0;

while abs(x1-x0) > eps
    x0 = x1;
    x1 = g(x0);
    k = k+1;
end

fprintf('\n\n����� ������� �������� � ��������� e = %.1f', eps);
fprintf('\n���������� �������� k=%d', k);
fprintf('\n������ ��������� x=%.4f', x1);
% ���������� ��� �����: ���� � ������ 0.7392 � ������ � ������ 0.3624
fprintf('\n�������� (�����������): %f', f(x));


% ����� ����
eps = 0.00001;
k_max = 1000;
k=0;
x = b;
z = a;

h = ((x-z)*f(x))/(f(x)-f(z));
while abs(h) > eps
    h = ((x-z)*f(x))/(f(x)-f(z));
    x = x-h;
    k = k + 1;
end

fprintf('\n\n����� ���� � ��������� e = %.5f', eps);
fprintf('\n���������� �������� k=%d', k);
fprintf('\n������ ��������� x=%.3f', x);
fprintf('\n�������� (�����������): %f', f(x));
 
 
% ����� �����������
eps = 0.00001;
k=0;

if (f(b)*subs(df2,b)) > 0
    x = b;
else
    x = a;
end

h = f(x) / df1(x);
while abs(h) > eps
h = f(x)/df1(x);
x = x-h;
k = k + 1;
end

fprintf('\n\n����� ����������� � ��������� e = %.5f', eps);
fprintf('\n���������� �������� k=%d', k);
fprintf('\n������ ��������� x=%.3f', x);
fprintf('\n�������� (�����������): %f', f(x));
 
 
% ����� �������
eps = 0.00001;
k=0;

if (f(b)*subs(df2,b)) > 0
    x = b;
else
    x = a;
end

while abs(x - x0) > eps
x0 = x;
x = x - (f(x)*eps)/(f(x+eps)-f(x));
k = k + 1;
end

fprintf('\n\n����� ������� � ��������� e = %.5f', eps);
fprintf('\n���������� �������� k=%d', k);
fprintf('\n������ ��������� x=%.3f', x);
fprintf('\n��������: %f', f(x));
