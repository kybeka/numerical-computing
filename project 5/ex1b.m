close("all");

% Define the range of values for x and y
x = -10:1:300;
y = -10:1:300;

% Create a figure with number 2
figure(1);

% Create a meshgrid for x and y
[X, Y] = meshgrid(x, y);

% Define the inequality conditions
inequality_condition = (X >= 0) & (Y >= 0) & (Y <= 265 - X) & ((Y <= 1400 - 5 .* X) ./ 8);

% Convert the logical array to double
inequality_condition = double(inequality_condition);

% Replace zeros with NaN to visualize only the valid solutions
inequality_condition(inequality_condition == 0) = NaN;

% Create a pseudocolor plot (pcolor) to visualize the solutions with a combination of red and yellow for an orange-like color
plot_handle = pcolor(X, Y, double(inequality_condition));
colormap([1 0.5 0]); % Use a combination of red and yellow for an orange-like color

% Remove edges for a cleaner plot
plot_handle.EdgeColor = 'none';

% Add a title to the plot
title('Solutions for Prob. 2');

% Mark two points in 3D space
hold on;
scatter3(1, 265, 0, 'r', 'filled', 'DisplayName', 'Red (1, 265, 0)'); % Point at x = 1, y = 265, z = 0
scatter3(265, 1, 0, 'b', 'filled', 'DisplayName', 'Blue (265, 1, 0)'); % Point at x = 265, y = 1, z = 0
hold off;

% Set the HandleVisibility property of the plot to 'off' to hide it in the legend
set(plot_handle, 'HandleVisibility', 'off');

% Add legend to the right
legend('Location', 'eastoutside');