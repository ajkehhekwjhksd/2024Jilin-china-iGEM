clear, clc
syms c d c_1
% substitute the initial value for c_1
c_1 = 49.7*0.8;

% the data
t = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];  
a = 0.6228;
b1 = 2.603;
b2 = 3.026;
c12 = 0.0208;
t1 = 2;
t2 = 40;
y1 = 100*(c12+1/t1-1/t2)./((1/t1-1/t2)+c12*exp((1/t1+c12-1/t2).*t));  % the equation of the proportion of the normal active bacteria

t12 = t1*a;
c122 = c12*a;
t22 = t2*a;
y2 = 100*(c122+1/t12-1/t22)./((1/t12-1/t22)+c122*exp((1/t12+c122-1/t22).*t));

t13 = t1/b1;
c123 = c12*b1;
t23 = t2/b1;
y3 = 100*(c123+1/t13-1/t23)./((1/t13-1/t23)+c123*exp((1/t13+c123-1/t23).*t));

t14 = t1*a/b2;
c124 = c12*a*b2;
t24 = t2*a/b2;
y4 = 100*(c124+1/t14-1/t24)./((1/t14-1/t24)+c124*exp((1/t14+c124-1/t24).*t));

figure(1)
plot(t,y1,'-o',t,y2,'-o',t,y3,'-o',t,y4,'-og')  % plot the curves
title('the curve of the proportion of normal active bacteria')
xlabel('time/day')
ylabel('Normal active bacteria proportion/(％)')
legend('curve1','curve2','curve3','curve4','Location','northeast')
