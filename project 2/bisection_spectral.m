function [part1,part2] = bisection_spectral(A,xy,picture)
% bisection_spectral: Spectral partition of a graph.
%
% [part1,part2] = bisection_spectral(A) returns a partition of the n vertices
%                 of A into two lists part1 and part2 according to the
%                 spectral bisection algorithm of Simon et al:  
%                 Label the vertices with the components of the Fiedler vector
%                 (the second eigenvector of the Laplacian matrix) and partition
%                 them around the median value or 0.
% 
% bisection_spectral(A,xy,1) also draws a picture.


disp(' ');
disp(' Numerical Computing @ USI Lugano:   ');
disp(' Implement spectral bisection');
disp(' ');


% Steps
% 1. Construct the Laplacian.
G = graph(A,'omitselfloops');
L = laplacian(G); % results in a symmetric positive semi-definite matrix that expresses the various graph properties


% 2. Calculate its eigensdecomposition.
% and thus, retrieve the second smallest eigenvalue
[V, ~] = eigs(L, 2, 'sm');


% 3. Label the vertices with the components of the Fiedler vector.

vector = V(:, 2);

% 4. Partition them around their median value, or 0.

% The threshold value m around which we define the two partitions can be chosen in two ways:
% 1. median value of the chosen eigenvector
%  => The two partitions will have homogeneous size.
% 2. m = 0
% => Guarantees a lower amount of edge cuts between nodes.

% I/We will find the median based of the Fiedler vector.
med = median(vector);

part1 = find(vector <= med);
part2 = find(vector > med);

if picture == 1
    gplotpart(A, xy, part1); % we plot that which is less than the median
    title('Spectral bisection using the Fiedler Eigenvector');
end


% <<<< Dummy implementation to generate a partitioning
% n = size(A,1);
% map = zeros(n,1);
% map(1:round((n/2))) = 0; 
% map((round((n/2))+1):n) = 1;
% [part1,part2] = other(map);
% 
% if picture == 1
%     gplotpart(A,xy,part1);
%     title('Spectral bisection (dummy) using the Fiedler Eigenvector');
% end

% Dummy implementation to generate a partitioning >>>>


end
