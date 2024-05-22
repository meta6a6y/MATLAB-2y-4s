clc; clear all;

a = 0;
b = 1.4;
h = 0.001;
x = [a:h:b];


f = @(m) cos(m) .* exp(m .^ 2);

funcddy = @(m) 2*m*exp(m.^2).*cos(m) - exp(m.^2).*sin(m);

d4y = @(m) (-12*(1 + 2*m^2)*cos(m) + 4*(3 + 4*m^4 + 12*m^2)*cos(m) + 8*m*sin(m)...
        - 16*m*(3 + 2*m^2)*sin(m) + cos(m))*exp(m^2);

    
anAns = 1.753031574;
y = f(x);
fprintf('Ответ аналитически: %f', anAns);

figure;
plot(x, y, 'r');
grid on
xlabel('x'); ylabel('y');
title('График функции');

legend('f(x)');

% Вычисление интеграла методом трапеций с определённой точностью
e = 1e-2;%точность
% m2 = max(ddy);
% h = sqrt((12*e) / ((b-a)*m2));
h = 0.2;
n = 0; %счетчик итераций
trpzAns = 0;
oldAns = 0;
while 1 
    for i = a:h:(b-h)
        r = -((h^3)/12)*funcddy(i);
        tempS = (h/2)*(f(i) + f(i + h)) + r;
        trpzAns = trpzAns + tempS;
        n = n + 1;
    end
    if abs(oldAns - trpzAns)< e
        break;
    else
        h = h/2;
        oldAns = trpzAns;
        trpzAns = 0;
        n = 0;
    end
end
fprintf('\nОтвет методом Трапеций с точностью %.2f: %f\n\tn = %d; h=%.3f',...
    e, trpzAns, n, h);
 
h = 0.4;
for j = 1:1:10
    newTrpz = 0;
    for i = a:h:(b-h)
        r = -((h^3)/12)*funcddy(i);
        tempS = (h/2)*(f(i) + f(i + h)) + r;
        newTrpz = newTrpz + tempS;
    end
    eList(j) = abs(anAns - newTrpz);
    hs(j) = h;
    h = h/2;
end
fprintf('\nМассив погрешностей зависимости от величины шага:\n');
fprintf('%f\n', eList);
figure;
plot(hs, eList, '-*r');
axis([-0.05, 0.45, -0.1, 0.35]);
grid on
hold off
legend('Погрешность');
legend('Location', 'northwest');
title('График зависимости погрешности от вечиличны шага');
xlabel('Величина шага'); ylabel('Погрешность');
 
% Решение с помощью метода Симпсона
e = 1e-4;
h = 0.2;
n = 0;
oldAns = 0;
sympAns = 0;
while 1
    for i = (a+h):2*h:(b-h)
        r = -((h.^5)/90).*d4y(i);
        tempS = (h/3)*(f(i-h) + 4*f(i)+ f(i + h));
        sympAns = sympAns + tempS;
        n = n + 1;
    end
    if abs(oldAns - sympAns)< e
        break;
    else
        h = h/2;
        oldAns = sympAns;
        sympAns = 0;
        n = 0;
    end
end
fprintf('\nОтвет методом Симпсона с точностью %.4f: %f\n\tn = %d; h=%.4f',...
    e, sympAns, n, h);
 
% Вычисление интеграла методом трапеций c помощью встроенных функций
trpz = trapz(x, y);
fprintf('\nОтвет методом Трапеций встроенной функцией ML: %f', trpz);
 
% Вычисление интеграла методом Симпсона c помощью встроенных функций
e = 1e-4;
smp = quad('cos(x).*exp(x.^2)',a, b, e);
fprintf('\nОтвет методом Симпсона встроенной функцией ML: %f', smp);
 
% Сравнение полученных результатов
fprintf('\nПогрешности в сравнении с аналитическим ответом:\n');
fprintf('\tМетод трапеций: %f\n', anAns-trpzAns);
fprintf('\tМетод Симпсона: %f\n', anAns-sympAns);
fprintf('\tВстроенный метод трапеций: %f\n', anAns-trpz);
fprintf('\tВстроенный метод Симпсона: %f\n', anAns-smp);
 

% 
% function y = f(m)
%     y = cos(m).*exp(m.^2);
% end
% function y = funcddy(m)
%     y = 2*m*exp(m.^2)*cos(m) - exp(m.^2)*sin(m);
% end
% function y = d4y(m)
%     y = (-12*(1 + 2*m^2)*cos(m) + 4*(3 + 4*m^4 + 12*m^2)*cos(m) + 8*m*sin(m)...
%         - 16*m*(3 + 2*m^2)*sin(m) + cos(m))*exp(m^2);
% end
