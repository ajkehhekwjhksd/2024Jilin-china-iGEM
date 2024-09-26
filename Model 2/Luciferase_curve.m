clear, clc

% Define temperature data points T and corresponding y values  
T = [2.5, 7.5, 12.5, 17.5, 22.5, 27.5, 32.5, 37.5, 42.5, 47.5];  
y = [0, 1000, 11000, 15000, 18000, 18000, 14500, 9500, 5000, 0];  

% Use polyfit function to perform quadratic polynomial fitting  
% The second argument of polyfit, 2, indicates a quadratic function  
coefficients = polyfit(T, y, 2);  

% Extract coefficients a, b, c  
a = coefficients(1);  
b = coefficients(2);  
c = coefficients(3);  

% Output the fitted quadratic function  
fprintf('The fitted quadratic function is: y = %.4f * T^2 + %.4f * T + %.4f\n', a, b, c);  

% Find the roots of the quadratic function  
discriminant = b^2 - 4*a*c;  
if discriminant >= 0  
    % Calculate the two roots  
    root1 = (-b + sqrt(discriminant)) / (2*a);  
    root2 = (-b - sqrt(discriminant)) / (2*a);  
    fprintf('The roots of the quadratic function are: T1 = %.4f and T2 = %.4f\n', root1, root2);  
else  
    fprintf('The quadratic function does not have real roots.\n');  
end  

% Calculate the fitted y values for each T point based on the polynomial coefficients  
y_fit_each = polyval(coefficients, T);  

% Calculate residuals  
residuals = abs(y - y_fit_each);  

% Calculate Total Sum of Squares (SST) and Sum of Squared Residuals (SSR)  
SST = sum((y - mean(y)).^2);  
SSR = sum(residuals.^2);  

% Calculate R^2 value  
R_squared = 1 - (SSR / SST);  

% Print R^2 and residuals  
fprintf('The coefficient of determination R^2: %.4f\n', R_squared);  
fprintf('Residuals:  %.4f\n',sum(residuals));  

% Define temperature range for plotting, for a smoother curve  
T_fit = linspace(min(T), max(T), 100);  

% Calculate the fitted y values based on the polynomial coefficients  
y_fit = polyval(coefficients, T_fit);  

% Create a new figure  
figure;  

% Plot original data points  
plot(T, y, 'o', 'MarkerSize', 8, 'DisplayName', 'Original Data');  

% Hold the current plot for further plotting  
hold on;  

% Plot the fitted quadratic curve  
plot(T_fit, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Fitted Curve');  

% Set x-axis limits to ensure only data above the axis is shown  
xlim([min(T_fit), max(T_fit)]);  

% Set y-axis limits to only show y values above zero  
ylim([0, max(y_fit) * 1.1]);  

% Add legend  
legend;  

% Add title and axis labels  
title('Fitting of Enzyme Activity versus Temperature');  
xlabel('Temperature T');  
ylabel('Activity y');  

% Release figure hold  
hold off;