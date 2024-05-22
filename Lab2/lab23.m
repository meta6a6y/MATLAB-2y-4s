syms f(x,y,z)
f(x,y,z) = x*sin(y)+z^(1/3);
dx = 0.01;
dy = 0.001;
dz = 0.1;
Df_x = diff(f,x);
Df_y = diff(f,y);
Df_z = diff(f,z);
du=Df_x(-3.59,0.467,563.2)*dx+Df_y(-3.59,0.467,563.2)*dy+Df_z(-3.59,0.467,563.2)*dz;
du_double = double(du);
new_u = log(abs(f));
Df_x = diff(new_u,x);
Df_y = diff(new_u,y);
Df_z = diff(new_u,z);
odu = Df_x(-3.59,0.467,563.2)*dx+Df_y(-3.59,0.467,563.2)*dy+Df_z(-3.59,0.467,563.2)*dz;
odu_double = double(odu);
fprintf('Абсолютная погрешность f = %f\n',du_double);
fprintf('Относительная погрешность f = %f %\n',odu_double);