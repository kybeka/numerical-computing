% Load blurred image and create vectorized version
load('blur_data/B.mat', 'B');
img = B;
height = size(img, 1);

% Vectorize the blurred image
b = B(:);

% Load system matrix A and set up parameters
load('blur_data/A.mat', 'A');
guess = ones(size(b));
max_iterations = 200;
tolerance = 1e-6;
alpha = 0.01;

% Configure options for incomplete Cholesky preconditioner
options.type = 'nofill';
options.diagcomp = alpha;

% Form the normal equations and apply the incomplete Cholesky preconditioner
height_A = transpose(A) * A;
height_B = transpose(A) * b;
Q = ichol(height_A, options);
P = transpose(Q) * Q;

% Solve the linear system using custom CG
[x_myCG, rvec_myCG] = myCG(A, b, guess, max_iterations, tolerance);

% Solve the preconditioned linear system using in-built PCG
[x_pcg, ~, ~, iter, rvec_pcg] = pcg(height_A, height_B, tolerance, max_iterations);

% Display the original blurred image
figure;
imagesc(reshape(img, [height, height]));
colormap gray;
title('Original Blurred Image');
axis image;

% Display the deblurred image using custom CG
figure;
imagesc(reshape(x_myCG, [height, height]));
colormap gray;
title('Deblurred Image using Custom CG');
axis image;

% Display the deblurred image using in-built PCG
figure;
imagesc(reshape(x_pcg, [height, height]));
colormap gray;
title('Deblurred Image using In-built PCG');
axis image;

% Display the convergence plot for custom CG
figure;
semilogy(rvec_myCG);
title('Custom CG Convergence Test');
xlabel('Iterations');
ylabel('Residual');

% Display the convergence plot for in-built PCG
figure;
semilogy(rvec_pcg);
title('In-built PCG Convergence Test');
xlabel('Iterations');
ylabel('Residual');
