clear all; clc

f1=@(x, y1, y2)y1*exp(x^2) + x*y2;

f2=@(x, y1, y2)3*x - y1 + 2*y2;

x0 = 0; xk = 3;
y10 = 1; y20 = 1;
h = 0.1;
x = x0:h:xk;
len = abs((x0-xk)/h);

fprintf('∆есткость системы на каждом шаге:\n');
for i=1:(len+1)
    A=[exp(x(i)^2) x(i); -1 2];
    Liambda = eig(A);
    S(i) = max(real(Liambda))/min(real(Liambda));
    fprintf('\tx = %f; s = %f\n', x(i), S(i));
end

% ћетод Ёйлера
y1(1) = y10;
y2(1) = y20;

for i=1:len
    y1(i+1) = y1(i) + h*f1(x(i), y1(i), y2(i));
    y2(i+1) = y2(i) + h*f2(x(i), y1(i), y2(i));
    
    % ќценка жесткости системы
    A=[exp(x(i)^2) x(i); -1 2];
    Liambda = eig(A);
    S(i) = max(real(Liambda))/min(real(Liambda));
end
fprintf('\n–езультаты решени€ €вным методом Ёйлера:\n');
for i=1:(len+1)
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end
figure;
plot3(x, y1, y2, '-*r');
grid on
title('явный Ёйлера');
xlabel('x'); ylabel('y1'); zlabel('y2');
legend('явный Ёйлера');
legend('Location', 'northwest');
legend('boxoff');

figure;
plot(x, y1, '-*r');
hold on
plot(x, y2, '-*black');
grid on
title('явный Ёйлера');
xlabel('x'); ylabel('y');
legend('y1', 'y2');


% не€вный метод Ёйлера
y1(1) = y10;
y2(1) = y20;
for i=1:len
    % y1(i+1) = y1(i) + h*f1(x(i), y1(i+1), y2) =>
    % y1(i+1) = y1(i) + h*(y1(i+1)*exp(x^2) + x*y2 =>
    % y1(i+1) = y1(i) + h*y1(i+1)*exp(x^2) + h*x*y2 =>
    % y1(i+1) - h*y1(i+1)*exp(x^2) = y1(i) + h*x(i+1)*y2 =>
    % y1(i+1)(1 - h*exp(x(i+1)^2)) = y1(i) + h*x(i+1)*y2 =>
    y1(i+1) = (y1(i) + h*x(i)*y2(i))/(1 - h*exp(x(i)^2));
    % y2(i+1) = y2(i) + h*(3*x - y1(i+1) + 2*y2(i+1)) =>
    % y2(i+1) = y2(i) + h*3*x - h*y1(i+1) + h*2*y2(i+1) =>
    % y2(i+1) - h*2*y2(i+1) = y2(i) + h*3*x - h*y1(i+1) =>
    % y2(i+1)*(1 - h*2) = y2(i) + h*3*x - h*y1(i+1) =>
    y2(i+1) = (y2(i) + h*(3*x(i) - y1(i+1)))/(1 - 2*h);
end
fprintf('\n–езультаты решени€ не€вным методом Ёйлера:\n');
for i=1:(len+1)
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end
figure;
plot3(x, y1, y2, '-*black');
grid on
title('не€вный метод Ёйлера');
xlabel('x'); ylabel('y1'); zlabel('y2');
legend('не€вный метод Ёйлера');
legend('Location', 'northwest');
legend('boxoff');

figure;
plot(x, y1, '-*r');
hold on
plot(x, y2, '-*black');
grid on
title('не€вный метод Ёйлера');
xlabel('x'); ylabel('y');
legend('y1', 'y2');

[x,y] = ode15s(@func2,[0 3],[1 1]);
yp = y';
fprintf('\n–езультаты решени€ с помощью функции ode15s:\n');
for i=1:length(yp)
    y1(i) = yp(1, i);
    y2(i) = yp(2, i);
    fprintf('\tx = %f; y1 = %f; y2 = %f\n', x(i), y1(i), y2(i));
end

figure;
for i=1:(length(x))
    hold on
    p1 = plot (x(i), y(i, 1), '-*g');
end
for i=1:(length(x))
    p2 = plot (x(i), y(i, 2), '-*b');
    hold on
end
hold on
plot(x, y, '-black');
grid on
title('ode15s');
xlabel('x'); ylabel('y');
legend([p1, p2], {'y1', 'y2'});
