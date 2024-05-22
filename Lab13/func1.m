function dy = func1(x,y)
dy = zeros(2,1);
dy(1) = y(1) * exp(-x.^2) + x * y(2);
dy(2) = 3*x - y(1) + 2*y(2);
end