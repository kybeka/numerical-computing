% Load data
load('test_data/A_test.mat', 'A_test');
load('test_data/b_test.mat', 'b_test');

% Determine matrix dimensions
[m, n] = size(A_test);

% Initial guess and iteration parameters
initialGuess = zeros(n, 1);
maxIterations = 200;
tolerance = 1e-4;

% Solve using custom Conjugate Gradient method
[x, rvec] = myCG(A_test, b_test, initialGuess, maxIterations, tolerance);

% Plot the convergence
figure;
plot(rvec);
xlabel('Iterations');
ylabel('Residual Values');
set(gca, 'YScale', 'log');
title('Convergence of Custom Conjugate Gradient');
