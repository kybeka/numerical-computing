% close all;
% clear;
% clc;
% 
% type = "max";
% 
% 
% c = [3, 4, 0, 0, 0];
% A = [4, 3, 1, 0, 0; 4, 1, 0, 1, 0; 4, 2, 0, 0, 1];
% h = [12; 8; 8];
% 
% sign = [-1, -1, -1];
% 
% [z,x_B,index_B] = simplex(type,A,h,c,sign);
% 

% Plot 
x = -0.1:0.01:5;  % Adjusted starting point
y = -0.1:0.01:5;  % Adjusted starting point
 
figure;

% Create a meshgrid for x and y
[X, Y] = meshgrid(x, y);

% Define the inequality conditions
ineq = (X >= 0) & (Y >= 0) & (Y <= 8 - 4.*X) & (Y <= 4 - 2.*X) & ((Y <= 12 - 4.*X)./3);
 
% Convert the logical array to double
ineq = double(ineq);
ineq(ineq == 0) = NaN;

% Create a pseudocolor plot (pcolor) to visualize the solutions with a combination of blue and cyan
plot_handle = pcolor(X, Y, double(ineq));
colormap([1 0.5 0]); 

% Remove edges for a cleaner plot
plot_handle.EdgeColor = 'none';

% Add a title to the plot
title('Feasible Region for Exercise 3');

% Set the x and y axis labels
xlabel('X-axis');
ylabel('Y-axis');

% Highlight specific points on the graph
hold on;
scatter(0, 4, 'ro', 'filled', 'DisplayName', 'Point (0, 4)'); % Point at x = 0, y = 4
scatter(2, 0, 'go', 'filled', 'DisplayName', 'Point (2, 0)'); % Point at x = 2, y = 0
hold off;


% Set the HandleVisibility property of the plot to 'off' to hide it in the legend
set(plot_handle, 'HandleVisibility', 'off');

% Add legend to the right
legend('Location', 'eastoutside');
