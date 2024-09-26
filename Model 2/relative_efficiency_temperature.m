clear, clc

% Define the function E with x = 0 for isotonic solutions  
E = @(y) 39.76 * (-36.5152 * y.^2 + 1848.7879 * y - 6666.4773) ./ ...  
    (0.0208 * exp(1863 * (1./(273.15 + y) - 1./(273.15 + 4))) + ...  
    0.5 * exp(-1863 * (1./(273.15 + y) - 1./(273.15 + 4))));  

% Define temperature range from 5°C to 45°C with 2°C steps  
temperatures = 5:2:45;  

% Calculate the effectiveness for each temperature  
effectiveness = E(temperatures);  

% Find the maximum effectiveness  
max_effectiveness = max(effectiveness);  

% Calculate relative effectiveness  
relative_effectiveness = effectiveness / max_effectiveness;  

% Output relative effectiveness  
fprintf('Temperature (°C) | Relative Effectiveness\n');  
fprintf('--------------------------------------\n');  
for i = 1:length(temperatures)  
    fprintf('        %2d       |       %.4f\n', temperatures(i), relative_effectiveness(i));  
end  

% Plot relative effectiveness  
figure;  
plot(temperatures, relative_effectiveness, 'o-', 'MarkerSize', 8, 'LineWidth', 2);  
xlabel('Temperature (°C)');  
ylabel('Relative Effectiveness');  
title('Relative Effectiveness vs Temperature');  
grid on;