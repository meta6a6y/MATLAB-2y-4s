clear all; clc
f=@(x)(1.5-x(1)+x(1).*x(2)).^2+(2.25-x(1)+x(1).*x(2).^2).^2+(2.625-x(1)+x(1).*x(2).^3).^2;

ax = -4.5; bx = 4.5;
ay = -4.5; by = 4.5;
eps1 = 1e-4;
%задаем максимально допустимое число итераций
iterm=5000;
ku = 2;
k = 1;
x(k) = bx;
y(k) = by;
R(k) = f([x(k), y(k)]);
while 1
    h = 1;
    dx(k) = dfx(x(k), y(k));
    dy(k) = dfy(x(k), y(k));
    deltx = dx(k)/(sqrt((dx(k)^2+dy(k)^2)));
    delty = dy(k)/(sqrt((dx(k)^2+dy(k)^2)));
    if and(abs(deltx), abs(delty)) < eps1
        break
    elseif k >= iterm
        break
    else
        while 1
            newx = x(k) - deltx*h;
            newy = y(k) - delty*h;
            newR = f([newx, newy]);
            if newR < R(k)
                break
            else
                h = h/ku;
            end
        end
        if h <= eps1
            break
        end
        k = k + 1;
        x(k) = newx;
        y(k) = newy;
        R(k) = newR;
    end    
end
figure;
plot3(x, y, R, '-.black');
grid on
title('Изменение минимума при поиске с помощью м. град. сп.');
xlabel('k'); ylabel('f(x)');
fprintf('Ответ за %d итерации с помощью метода градиентного спуска: %f; в точке [%f; %f]',...
    k, R(k), x(k), y(k));
xs = -4.5:0.1:4.5;
ys = -4.5:0.1:4.5;
for i=1:length(xs)
    for j=1:length(ys)
        z(i, j) = f([xs(i), ys(j)]);
    end
end
figure;
surf(xs, ys, z);
hold on
plot3(x, y, R, '-.r');
title('Поверхность значений');
 
fms = fminsearch(f, [4.5, 4.5]);
fprintf('\nОтвет с помощью fminsearch: %f; в точке [%f; %f]',...
    f(fms), fms);


dx(k) = dfx(x(k), y(k));
dy(k) = dfy(x(k), y(k));
