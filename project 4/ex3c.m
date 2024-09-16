% Compute eigenvalues of A_test
eigenvalues = eig(A_test);

% Set a threshold for including eigenvalues in the plot
threshold = 1e-8;
validIndices = abs(eigenvalues) > threshold;

% Plot the eigenvalues
figure;
bar(1:length(eigenvalues(validIndices)), abs(eigenvalues(validIndices)));
set(gca, 'YScale', 'log');
xlabel('Index');
ylabel('Eigenvalues');
title('Eigenvalues of A-test Matrix');

% Compute min, max, and condition number of eigenvalues
minEigenvalue = min(abs(eigenvalues(validIndices)));
maxEigenvalue = max(abs(eigenvalues(validIndices)));
conditionNumber = maxEigenvalue / minEigenvalue;

% Display information on the side of the plot
annotation('textbox', [0.75, 0.6, 0.1, 0.3], 'String', sprintf('Min Eigenvalue: %.4e\nMax Eigenvalue: %.4e\nCondition Number: %.4e', minEigenvalue, maxEigenvalue, conditionNumber), 'FitBoxToText', 'on', 'EdgeColor', 'none');
