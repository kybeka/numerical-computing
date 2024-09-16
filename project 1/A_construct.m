function [A, nz] = A_construct(n)
A = zeros(n);
for i = 1:n
    for j = 1:n
        if i ~= j && (i == 1 || i == n || j == 1 || j == n) && 
            A(i, j) = 1;
        elseif i == j
            A(i, j) = n + i - 1;
        end
    end
end
nz = 5*n-4;
disp("number of non-zero elements: ");
disp(nz);
spy(A);
end