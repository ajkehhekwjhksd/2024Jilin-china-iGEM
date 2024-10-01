% Prepare filename for GIF  
gifFilename = 'pulsating_tube.gif';  

% Define parameters for the tube  
innerRadius = 1.5; % Average inner radius in cm  
outerRadius = 2.5; % Average outer radius in cm  
baseLength = 5; % Base length of the tube in cm  
numPoints = 100; % Number of points for smoothness  

% Create base cylindrical coordinates  
theta = linspace(0, 2*pi, numPoints);  
z = linspace(0, baseLength, numPoints);  
[Theta, Z] = meshgrid(theta, z);  

% Calculate maximum radius for setting static axis  
maxRadius = outerRadius * 1.2;  % Include scale factor  

% Parameters for particles (glow points)  
numParticles = 150; % Number of particles  
particleTheta = 2 * pi * rand(numParticles, 1);  
particleZNorm = rand(numParticles, 1); % Normalized Z positions 

% Figure setup  
figure;  
xlabel('X (cm)');  
ylabel('Y (cm)');  
zlabel('Z (cm)');  
title('Dynamically Glowing and Pulsating Tube with Attached Particles');  
view(30, 30);  

% Create the animation  
numFrames = 80; % Number of frames for the animation  
for i = 1:numFrames  
    % Calculate the scaling factor for pulsation  
    scaleFactor = 0.95 + 0.05 * sin(i * 2.5 * pi / numFrames); % Range between 0.95 and 1.05  
    
    % Adjust radii based on the scale factor  
    currentInnerRadius = innerRadius * scaleFactor;  
    currentOuterRadius = outerRadius * scaleFactor;  
    
    % Calculate cross-sectional area scaling factor (proportional to radius^2)  
    areaScalingFactor = scaleFactor^2;  
    
    % Adjust length inversely proportional to cross-sectional area  
    currentLength = baseLength / areaScalingFactor;  
    
    % Convert to Cartesian coordinates for inner and outer cylinders  
    z = linspace(0, currentLength, numPoints);  
    [Theta, Z] = meshgrid(theta, z);  
    
    X_inner = currentInnerRadius * cos(Theta);  
    Y_inner = currentInnerRadius * sin(Theta);  
    X_outer = currentOuterRadius * cos(Theta);  
    Y_outer = currentOuterRadius * sin(Theta);  

    % Compute dynamic glow effect (slightly varying brightness)  
    alphaValue = 0.7; % Keep transparency stable for clarity  
    glowStrength = 0.85 + 0.15 * sin(i * 5 * pi / numFrames); % Moderate oscillation  
    glowColor = [0.3, 0.7, 1] * glowStrength; % Bright blue with dynamic intensity  

    % Clear previous plots  
    cla;  

    % Plot the outer tube with dynamic transparency and glow  
    surf(X_outer, Y_outer, Z, 'FaceColor', glowColor, 'EdgeColor', 'none', 'FaceAlpha', alphaValue);  
    hold on;  

    % Plot the inner tube for hollow effect  
    surf(X_inner, Y_inner, Z, 'FaceColor', [0 0 0], 'EdgeColor', 'none', 'FaceAlpha', 0.1);  

    % Add lighting effects  
    camlight('headlight');  
    lighting gouraud;  
    material([0.4, 0.6, 0.8]);  

    % Calculate particle positions, keeping them on the surface of the tube  
    particleX = currentOuterRadius * cos(particleTheta);  
    particleY = currentOuterRadius * sin(particleTheta);  
    particleZ = particleZNorm * currentLength; % Update Z based on new length  

    % Plot particles with adjusted visibility  
    scatter3(particleX, particleY, particleZ, 20, 'w', 'filled', 'MarkerFaceAlpha', 0.3 + 0.3 * glowStrength);  

    % Set static axis limits  
    xlim([-maxRadius maxRadius]);  
    ylim([-maxRadius maxRadius]);  
    zlim([0 baseLength * 1.5]); % Adjusted for potential max length range  
    axis equal;  
    
    % Capture the current frame  
    frame = getframe(gcf);  
    im = frame2im(frame);  
    [imind, cm] = rgb2ind(im, 256);  

    % Write to the GIF File  
    if i == 1  
        imwrite(imind, cm, gifFilename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);  
    else  
        imwrite(imind, cm, gifFilename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);  
    end  
    
    % Pause for a short time to create animation effect  
    pause(0.1);  
end