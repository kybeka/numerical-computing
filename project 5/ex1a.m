% Define the objective function coefficients
c = [4; 1];

% Define the inequality constraint matrix and vector
A = [1, 2; -1, -1; -2, -3];
b = [40; -30; -72];

% Define lower bounds for variables
lowerBounds = [0; 0];

% Generate points for plotting the inequalities
x_vals = linspace(0, 36, 100);
y1_vals = (40 - x_vals) / 2;
y2_vals = max(0, 30 - x_vals);
y3_vals = max((72 - 2*x_vals) / 3, 0);

% Plot the feasible region
figure;
hold on;

% Plot the inequalities
plot(x_vals, y1_vals, 'r', 'LineWidth', 2);  % x + 2y ≤ 40
plot(x_vals, y2_vals, 'g', 'LineWidth', 2);   % x + y ≥ 30
plot(x_vals, y3_vals, 'b', 'LineWidth', 2);    % 2x + 3y ≥ 72

% Highlight the feasible region
x_fill = [x_vals, fliplr(x_vals)];
y_fill = [min(y1_vals, max(y2_vals, y3_vals)), zeros(size(x_vals))];
fill(x_fill, y_fill, [0.5, 0.5, 0.5], 'FaceAlpha', 0.4);

% Calculate the optimal solution point
optimal_x = 24;  
optimal_y = 8;

% Plot the optimal solution point
plot(optimal_x, optimal_y, 'go', 'MarkerSize', 10, 'LineWidth', 2);

% Set plot properties
title('Feasible Region and Optimal Solution');
xlabel('x');
ylabel('y');
legend('x + 2y \leq 40', 'x + y \geq 30', '2x + 3y \geq 72', 'Feasible Region', 'Optimal Solution');

hold off;
