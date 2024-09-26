clear, clc
syms c d c_1
% substitute the initial value for c_1
c_1 = 49.7*0.8;

% the data
t = [4, 5, 6, 7, 8, 9, 13];  
x = [6.15, 4.35, 3.23, 2.40, 1.85, 1.72, 1.24];
% set the initial value for c to solve it
c = solve(c_1*((1/2-1/40)*exp(-(1/2+c)*7)+c*exp(-7/40))/(c+1/2-1/40)==2.4);
b0 = 0.0252;
fun = inline('49.7*0.8*((1/2-1/40)*exp(-(1/2+c).*t)+c.*exp(-t/40))./(c+1/2-1/40)','c','t');
[b1,r1,j1] = nlinfit(t,x,fun,b0);
b1
y = 49.7*0.8*((1/2-1/40)*exp(-(1/2+b1).*t)+b1.*exp(-t/40))./(b1+1/2-1/40);  % the equation obtained by nonlinear fitting
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




