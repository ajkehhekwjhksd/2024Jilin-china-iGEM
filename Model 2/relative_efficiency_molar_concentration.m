% Clear workspace and command window  
clear;  
clc;  

% Constants  
R = 8.314; % J/(mol·K), ideal gas constant  
T_kelvin_best = 273.15 + 20.7749; % Convert temperature to Kelvin  

% Define concentrations in mol/L with step size 0.02  
concentrations = 0:0.02:0.6;  

% Calculate osmotic pressures (Pa)  
pi0 = 0.155 * R * T_kelvin_best; % Osmotic pressure of physiological saline  
pi = concentrations * R * T_kelvin_best; % Osmotic pressure for different concentrations  

% Calculate the difference in osmotic pressure  
delta_pi = pi - pi0;  

% Define the function E at optimum temperature  
E = @(x) 39.76 * (-36.5152 * 20.7749^2 + 1848.7879 * 20.7749 - 6666.4773) ./ ...  
    (0.0208 * exp(7.50e-6 * x.^2 + 1863 * (1./(273.15 + 20.7749) - 1./(273.15 + 4))) + ...  
    0.5 * exp(7.50e-6 * x.^2 - 1863 * (1./(273.15 + 20.7749) - 1./(273.15 + 4))));  

% Calculate effectiveness for each delta_pi  
effectiveness = E(delta_pi);  

% Find the maximum effectiveness  
max_effectiveness = max(effectiveness);  

% Calculate relative effectiveness  
relative_effectiveness = effectiveness / max_effectiveness;  

% Output results  
fprintf('Concentration (mol/L) | Relative Effectiveness\n');  
fprintf('---------------------------------------------\n');  
for i = 1:length(concentrations)  
    fprintf('        %.2f         |       %.4f\n', concentrations(i), relative_effectiveness(i));  
end  

% Plot relative effectiveness with smooth curve  
figure;  
plot(concentrations, relative_effectiveness, '-o', 'MarkerSize', 8, 'LineWidth', 2); % Add line style for smooth curve  
xlabel('Salt Concentration (mol/L)');  
ylabel('Relative Effectiveness');  
title('Relative Effectiveness vs Salt Concentration at T = 20.7749°C');  
grid on;
