clear, clc
syms c d c_1
% substitute the initial value for c_1
c_1 = 49.7*0.8;

% the data
t = [4, 5, 6, 7, 8, 9, 13];  
x = [2.12, 1.12, 0.836, 0.618, 0.543, 0.463, 0.382];
% set the initial value for c to solve it
c = solve(49.7*0.8*((1/(2*c)-1/(40*c))*exp(-(1/(2*c)+0.0208*c)*7)+0.0208*c*exp(-7/(40*c)))/(0.0208*c+1/(2*c)-1/(40*c))==0.631);
c
b0 = 0.6;
fun = inline('49.7*0.8*((1/(2*c)-1/(40*c)).*exp(-(1/(2*c)+0.0208*c).*t)+0.0208*c.*exp(-t./(40*c)))./(0.0208*c+1/(2*c)-1/(40*c))','c','t');
[b1,r1,j1] = nlinfit(t,x,fun,b0);
b1
y = 49.7*0.8*((1/(2*b1)-1/(40*b1)).*exp(-(1/(2*b1)+0.0208*b1).*t)+0.0208*b1.*exp(-t./(40*b1)))./(0.0208*b1+1/(2*b1)-1/(40*b1));  % the equation obtained by nonlinear fitting
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