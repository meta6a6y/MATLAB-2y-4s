function p=dfx(x, y)
     p = 2*(y^2 - 1)*(x*y^2 - x + 9/4) + 2*(y^3 - 1)*(x*y^3 - x + 21/8)...
         + 2*(y - 1)*(x*y - x + 3/2);
 end