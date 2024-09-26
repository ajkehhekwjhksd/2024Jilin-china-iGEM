clear, clc
syms c d c_1
% substitute the initial value for c_1
c_1 = 49.7*0.8;

% the data
t = [4, 5, 6, 7, 8, 9, 13];  
x = [0.44, 0.37, 0.31, 0.28, 0.24, 0.22, 0.15];
a = 0.6228;
b1 = 3.026;
y = 49.7*0.8*((1/(2*a)-1/(40*a)).*exp(-(b1/(2*a)+0.0208*a*b1).*t)+0.0208*a*exp(-b1.*t./(40*a)))/(0.0208*a+1/(2*a)-1/(40*a));  % the equation obtained by nonlinear fitting
figure(1)
plot(t,x,'-*',t,y,'-or')  % plot the original data with the value after curve fitting
title('the curve after fitting the original data to the curve')
xlabel('time/day')
ylabel('Bacterial population density/(MCFU/mL)')
legend('original curve','fitted curve','Location','northeast')
r1 = y-x;
R1 = sum(r1.^2);
R2 = sum((x-mean(x)).^2);
R = 1-R1/R2;      % coefficient of determination
W = sum(abs(r1));      % sum of absolute residuals
R
W