clear all; clc
 
f=@(x)0.25*pi*x.^2+(6000/x);
df=@(x)-6000/x^2 + pi*x/2;
d2f=@(x)pi/2 + 12000/x^3;
 
figure;
ezplot('0.25*pi*x^2+(6000/x)', [0, 30]);
xlabel('x'); ylabel('y');
grid on;
 
% исходя из графика делаем вывод, что точка минимума находится между 10 и 20
a = 10; b = 20;
 
% ЗОЛОТОЕ СЕЧЕНИЕ
%определяем точность нахождения точки минимума
eps=1e-3;
%определяем константу ksi и z
ksi=(sqrt(5)-1)/2;
z = 1 - ksi; 
%определяем левую и правую границы отрезка
xl=a; xr=b;
%определяем номер итерации
k=1;
%организуем цикл метода поиска точки минимума методом ЗОЛОТОГО СЕЧЕНИЯ
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
% График номера итерации от оптимального значения
figure
plot(1:k-1, xBst, '-*r');
grid on
xlabel('k'); ylabel('x');
title('Золотое сечение');
fprintf('Ответ с помощью метода ЗОЛОТОГО СЕЧЕНИЯ: %f\n\tкол-во итераций: %d',...
    xBst(k-1), k-2);
 
% МЕТОД ПАРАБОЛ
%определяем параметр h метода парабол
h=1e-4;
%определяем число итераций в методе парабол
iterm=10;
%задаем набор начальных значений
x0=a:1:b;
%организуем цикл расчетов по методу парабол стартуя с каждого начального значения
figure;
for i=1:length(x0)
    xs=x0(i);
    iter=1; x(1)=xs;
    %организуем цикл итераций метода парабол
    while iter<iterm
        xs=xs-0.5*h*((f(xs+h)-f(xs-h))/...
                (f(xs+h)-2*f(xs)+f(xs-h)));
        iter=iter+1; x(iter)=xs;
    end
    %наносим очередной график зависимости значений итераций от номера итераций
    plot(1:iter, x);
    hold on
end
xlabel('k'); ylabel('x');
title('Парабол');
grid on
fprintf('\nОтвет с помощью метода ПАРАБОЛ: %f\n\tкол-во итераций: %d',...
    x(iter), iter);
 
% НЬЮТОНА
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
title('Ньютона');
fprintf('\nОтвет с помощью метода НЬЮТОНА: %f\n\tкол-во итераций: %d',...
    xN(k), k);
fprintf('\nОтвет с помощью функции fminbnd: %f', fminbnd(f, a, b));

