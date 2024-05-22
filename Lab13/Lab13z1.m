clear all; clc

f1=@(x, y1, y2)y1*exp(-x^2) + x*y2;

f2=@(x, y1, y2)3*x - y1 + 2*y2;

x0 = 0; xk = 1;
y10 = 1; y20 = 1;
h = 0.1;
x = x0:h:xk;
len = abs((x0-xk)/h);

fprintf('Жесткость системы на каждом шаге:\n');
for i=1:(len+1)
    A=[exp(-x(i)^2) x(i); -1 2];
    Liambda = eig(A);
    S(i) = max(real(Liambda))/min(real(Liambda));
    fprintf('\tx = %f; s = %f\n', x(i), S(i));
end

% Метод Эйлера
fprintf('\nРезультаты решения методом Эйлера:\n');
y1(1) = y10;
y2(1) = y20;
fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(1), y1(1), y2(1));
for i=1:len
    y1(i+1) = y1(i) + h*f1(x(i), y1(i), y2(i));
    y2(i+1) = y2(i) + h*f2(x(i), y1(i), y2(i));
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i+1), y1(i+1), y2(i+1));
end
figure;
plot3(x, y1, y2, '-*r');

% Модифицированный метод Эйлера
y1(1) = y10;
y2(1) = y20;
for i=1:len
    ty1 = y1(i) + h*f1(x(i), y1(i), y2(i));
    ty2 = y2(i) + h*f2(x(i), y1(i), y2(i));
    y1(i+1) = y1(i) + 0.5*h*(f1(x(i), y1(i), y2(i)) + f1(x(i+1), ty1, ty2));
    y2(i+1) = y2(i) + 0.5*h*(f2(x(i), y1(i), y2(i)) + f2(x(i+1), ty1, ty2));
end
fprintf('\nРезультаты решения модифицированным методом Эйлера:\n');
for i=1:(len+1)
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end
hold on
plot3(x, y1, y2, '-*b');

% Метод Рунге-Кутта
y1(1) = y10;
y2(1) = y20;
for i=1:len
    x1 = x(i) + 0.5*h;
    x2 = x(i) + h;
    k1 = h*f1(x(i), y1(i), y2(i));
    l1 = h*f2(x(i), y1(i), y2(i));
    k2 = h*f1(x1, y1(i)+0.5*k1, y2(i)+0.5*l1);
    l2 = h*f2(x1, y1(i)+0.5*k1, y2(i)+0.5*l1);
    k3 = h*f1(x1, y1(i)+0.5*k2, y2(i)+0.5*l2);
    l3 = h*f2(x1, y1(i)+0.5*k2, y2(i)+0.5*l2);
    k4 = h*f1(x2, y1(i)+k3, y2(i)+l3);
    l4 = h*f2(x2, y1(i)+k3, y2(i)+l3);
    
    deltaY1 = (k1 + 2*k2 + 2*k3 + k4)/6;
    deltaY2 = (l1 + 2*l2 + 2*l3 + l4)/6;
    
    y1(i+1) = y1(i) + deltaY1;
    y2(i+1) = y2(i) + deltaY2;
end
fprintf('\nРезультаты решения методом Рунге-Кутта:\n');
for i=1:(len+1)
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end
hold on
plot3(x, y1, y2, '-oblack');

[x,y] = ode15s(@func1,[0 1],[1 1]);
y = y';
fprintf('\nРезультаты решения с помощью функции ode15s:\n');
for i=1:length(y)
    y1(i) = y(1, i);
    y2(i) = y(2, i);
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end
hold on
plot3(x, y1, y2, '-*m');
grid on
title('Графики');
xlabel('x'); ylabel('y1'); zlabel('y2');
legend('Эйлера', 'Мод. Эйлера', 'Рунге-Кутта 4-го пор.', 'ode15s');
legend('Location', 'northwest');
legend('boxoff');

figure;
p1 = plot(x, y1, '-*g');
hold on
p2 = plot(x, y2, '-*b');
grid on
title('ode15s');
xlabel('x'); ylabel('y');
legend([p1, p2], {'y1', 'y2'});

