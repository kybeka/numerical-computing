function [x_B, c_B, index_B] = simplexSolve(type, B, D, c_B, c_D, h, x_B, x_D, index_B, index_D, itMax)
    % Solving a maximization problem with the simplex method

    % Initialize the number of iterations
    nIter = 0;

    % Compute B^{-1}*D and B^{-1}*h
    BiD = B \ D;
    Bih = B \ h;

    % Compute the reduced cost coefficients
    r_D = c_D - c_B * BiD;

    tol = max(size(r_D)); % the optimality condition is satisfied if all reduced cost coefficients are positive or negative (depending on the problem)

    % Check the optimality condition, in order to skip the loop if the solution is already optimal
    if strcmp(type, 'max')
        optCheck = sum(r_D < 0);
    elseif strcmp(type, 'min')
        optCheck = sum(r_D > 0);
    else
        error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
    end

    % Continue iterating until the optimality condition reaches the specified tolerance
    while optCheck ~= tol
        fprintf("x_B\n");
        disp(x_B);
        
        if optCheck
            break;
        end

        % Find the index of the entering variable
        if strcmp(type, 'max')
            [~, idxIN] = max(r_D);
        elseif strcmp(type, 'min')
            [~, idxIN] = min(r_D);
        else
            error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
        end

        in = D(:, idxIN);
        c_in = c_D(1, idxIN);
        index_in = index_D(1, idxIN);

        % Evaluate the coefficients ratio for the column corresponding to the entering variable
        ratio = Bih ./ BiD(:, idxIN);

        % Find the smallest positive ratio
        idxOUT = find(ratio == min(ratio(ratio >= 0)), 1);

        out = B(:, idxOUT);
        c_out = c_B(1, idxOUT);
        index_out = index_B(1, idxOUT);

        % Update the matrices by exchanging the columns
        B(:, idxOUT) = in;
        D(:, idxIN) = out;
        c_B(1, idxOUT) = c_in;
        c_D(1, idxIN) = c_out;
        index_B(1, idxOUT) = index_in;
        index_D(1, idxIN) = index_out;

        % Compute B^{-1}*D and B^{-1}*h
        BiD = B \ D;
        Bih = B \ h;

        % Compute the reduced cost coefficients
        r_D = c_D - c_B * BiD;

        % Check the optimality condition 
        if strcmp(type, 'max')
            optCheck = sum(r_D < 0);
        elseif strcmp(type, 'min')
            optCheck = sum(r_D > 0);
        else
            error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
        end

        % Detect inefficient looping if nIter > total number of basic solutions
        nIter = nIter + 1;
        
%         fprintf("Index In \n");
%         disp(index_in)
%         fprintf("Index Out\n");
%         disp(index_out);


        if nIter > itMax
           error('Incorrect loop, more iterations than the number of basic solutions');
        end

        % Compute the new x_B
        x_B = Bih - BiD * x_D;

    end

end
