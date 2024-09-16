function [x, rvec] = myCG(A, b, x0, max_itr, tol)
    % Initialize variables
    rvec = [];
    x = x0;
    residual = b - A * x;
    direction = residual;
    residual_norm_old = dot(residual, residual);

    % Conjugate Gradient iteration
    for itr = 1:max_itr
        % Compute matrix-vector product
        product = A * direction;

        % Update solution
        alpha = residual_norm_old / dot(direction, product);
        x = x + alpha * direction;

        % Update residual
        residual = residual - alpha * product;

        % Update squared residual norm
        residual_norm_new = dot(residual, residual);

        % Update conjugate direction
        beta = residual_norm_new / residual_norm_old;
        direction = residual + beta * direction;

        % Update previous squared residual norm
        residual_norm_old = residual_norm_new;

        % Store squared residual norms for analysis
        rvec = [rvec, residual_norm_new];

        % Check convergence
        if sqrt(residual_norm_new) <= tol
            disp('Converged');
            break;
        end
    end
end
