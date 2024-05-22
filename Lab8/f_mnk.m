function s = f_mnk(c)
    global x;
    global y;
    s = 0;
    for i = 1:length(x)
        s = s + (y(i) - c(1) - c(2)*x(i)^2 - c(3)*x(i)^3)^2;
    end
end