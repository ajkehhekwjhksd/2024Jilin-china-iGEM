clear,clc;

% Define the function E  
E = @(x, y) 39.76 * (-36.5152 * y.^2 + 1848.7879 * y - 6666.4773) ./ ...  
    (0.0208 * exp(7.50e-12 * x.^2 + 1863 * (1./(273.15 + y) - 1./(273.15 + 4))) + ...  
    0.5 * exp(7.50e-12 * x.^2 - 1863 * (1./(273.15 + y) - 1./(273.15 + 4))));  

% Inverse of the function E for minimization (since fminunc minimizes)  
invE = @(vars) -E(vars(1), vars(2));  

% Define the range for temperature T and osmotic pressure difference x  
T = linspace(3.9, 46.7, 100);  
x = linspace(-500000, 500000, 100);  

% Create a meshgrid for T and x  
[X, Y] = meshgrid(x, T);  

% Calculate E values for plotting  
Z = E(X, Y);  

% Plot the surface  
figure;  
surf(X, Y, Z);  
xlabel('Osmotic Pressure Difference (\pi - \pi_0)');  
ylabel('Temperature (T)');  
zlabel('E');  
title('Surface plot of E as a function of Temperature and Osmotic Pressure Difference');  
colorbar;  

% Optimization using fminunc  
options = optimset('Display', 'iter', 'TolX', 1e-6, 'TolFun', 1e-6);  
initial_guess = [0, 25]; % Start at (x0, y0)  
[min_vars, max_E] = fminunc(invE, initial_guess, options);  

% Since invE is the negative of E, negate the result to get the actual max  
max_E = -max_E;  

% Output the results  
fprintf('The maximum value of E is %.4f at T = %.4f°C ,\n and the osmotic pressure difference at %.4f\n Pa', max_E, min_vars(2), min_vars(1));