clear all; clc
 
f=@(x)0.25*pi*x.^2+(6000/x);
df=@(x)-6000/x^2 + pi*x/2;
d2f=@(x)pi/2 + 12000/x^3;
 
figure;
ezplot('0.25*pi*x^2+(6000/x)', [0, 30]);
xlabel('x'); ylabel('y');
grid on;
 
% ������ �� ������� ������ �����, ��� ����� �������� ��������� ����� 10 � 20
a = 10; b = 20;
 
% ������� �������
%���������� �������� ���������� ����� ��������
eps=1e-3;
%���������� ��������� ksi � z
ksi=(sqrt(5)-1)/2;
z = 1 - ksi; 
%���������� ����� � ������ ������� �������
xl=a; xr=b;
%���������� ����� ��������
k=1;
%���������� ���� ������ ������ ����� �������� ������� �������� �������
x1 = xl + z*(xr - xl);
x2 = xr - z*(xr - xl);
while xr-xl > eps
    F1 = f(x1); F2 = f(x2);
    if (F1 <= F2)
        xBst(k) = x1;
        xr=x2; x2=x1; 
        x1 = xl + z*(xr - xl);
    else
        xBst(k) = x2;
        xl = x1;
        x1 = x2;
        x2 = xr - z*(xr - xl);
    end
    hold on
    k = k + 1;
end
% ������ ������ �������� �� ������������ ��������
figure
plot(1:k-1, xBst, '-*r');
grid on
xlabel('k'); ylabel('x');
title('������� �������');
fprintf('����� � ������� ������ �������� �������: %f\n\t���-�� ��������: %d',...
    xBst(k-1), k-2);
 
% ����� �������
%���������� �������� h ������ �������
h=1e-4;
%���������� ����� �������� � ������ �������
iterm=10;
%������ ����� ��������� ��������
x0=a:1:b;
%���������� ���� �������� �� ������ ������� ������� � ������� ���������� ��������
figure;
for i=1:length(x0)
    xs=x0(i);
    iter=1; x(1)=xs;
    %���������� ���� �������� ������ �������
    while iter<iterm
        xs=xs-0.5*h*((f(xs+h)-f(xs-h))/...
                (f(xs+h)-2*f(xs)+f(xs-h)));
        iter=iter+1; x(iter)=xs;
    end
    %������� ��������� ������ ����������� �������� �������� �� ������ ��������
    plot(1:iter, x);
    hold on
end
xlabel('k'); ylabel('x');
title('�������');
grid on
fprintf('\n����� � ������� ������ �������: %f\n\t���-�� ��������: %d',...
    x(iter), iter);
 
% �������
eps = 1e-4;
k = 1;
xN(k) = a;
while 1
    newX = xN(k) - (df(xN(k))/d2f(xN(k)));
    k = k + 1;
    xN(k) = newX;
    if abs(df(xN(k))) <= eps
        break
    end
end
figure
plot(1:k, xN, '-*b');
grid on
xlabel('k'); ylabel('x');
title('�������');
fprintf('\n����� � ������� ������ �������: %f\n\t���-�� ��������: %d',...
    xN(k), k);
fprintf('\n����� � ������� ������� fminbnd: %f', fminbnd(f, a, b));

