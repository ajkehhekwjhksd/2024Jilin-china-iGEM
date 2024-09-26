clear, clc
syms c d c_1
% substitute the initial value for c_1
c_1 = 49.7*0.8;

% the data
t = [4, 5, 6, 7, 8, 9, 13];  
x = [1.45, 1.26, 1.12, 1.07, 0.998, 0.930, 0.714];
% set the initial value for c to solve it
p = vpasolve(49.7*0.8*((1/2-1/40)*exp(-(c/2+0.0208*c)*7)+0.0208*exp(-7*c/(40)))/(0.0208+1/2-1/40) == 1.06, c, 2.5);
b0 = 3;
fun = inline('49.7*0.8*((1/2-1/40).*exp(-(c/2+0.0208*c).*t)+0.0208*exp(-c.*t/(40)))/(0.0208+1/2-1/40)','c','t');
[b1,r1,j1] = nlinfit(t,x,fun,b0);
b1
y = 49.7*0.8*((1/2-1/40).*exp(-(b1/2+0.0208*b1).*t)+0.0208*exp(-b1.*t/(40)))/(0.0208+1/2-1/40);  % the equation obtained by nonlinear fitting
figure(1)
plot(t,x,'-*',t,y,'-or')  % plot the original data with the value after curve fitting
title('the curve after fitting the original data to the curve')
xlabel('time/day')
ylabel('Bacterial population density/(MCFU/mL)')
legend('original curve','fitted curve','Location','northeast')
R1 = sum(r1.^2);
R2 = sum((x-mean(x)).^2);
R = 1-R1/R2;      % coefficient of determination
W = sum(abs(r1));      % sum of absolute residuals
R
W