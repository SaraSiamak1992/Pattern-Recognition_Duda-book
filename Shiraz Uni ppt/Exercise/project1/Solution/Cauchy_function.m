function f = Cauchy_function(x, a, b)
p1 = (pi*b)* (1+((x - a)/b) .^ 2);
f = 1./ p1; 