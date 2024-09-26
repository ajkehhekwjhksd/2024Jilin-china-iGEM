clear, clc
syms c
c = solve(exp(c*(1/(273.15+25)-1/(273.15+4)))==0.6228);
round(c,4)