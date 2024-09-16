function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial: Inertial partition of a graph.
%
% [part1,part2] = bisection_inertial(A,xy,picture) returns a list of the vertices on one side of a partition
%     obtained by bisection with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.

disp(' ');
disp(' Numerical Computing @ USI Lugano:   ');
disp(' Implement inertial bisection');
disp(' ');


% Steps
% 1. Calculate the center of mass.
center_mass = mean(xy);

% 2. Construct the matrix M.
% initialize
Mxx = 0;
Myy = 0;
Mxy = 0;

for i = 1:size(xy)
    Mxx = Mxx + (xy(i,1) - center_mass(1))^2;
    Myy = Myy + (xy(i,2) - center_mass(2))^2;
    Mxy = Mxy + (xy(i,1) - center_mass(1))*(xy(i,2) - center_mass(2));
end

% Matrix M expresses the distance of the vertices from the center of mass
M = [Mxx Mxy; Mxy Myy];

% 3. Calculate the smallest eigenvector of M.
% In order to minimize the sum of distances as much as possible we choose the smallest eigenvector for matrix M .
[eigenvector, eigenvalue] = eigs(M, 1, 'SA');

% ignore the eigenvalue

% 4. Find the line L on which the center of mass lies.
% We trace a line l across the space and partition the vertices based on whether they are on one side of the line 
% or the other.
a = eigenvector(1);
b = eigenvector(2);
L = [-b, a];

% 5. Partition the points around the line L.
%   (you may use the function partition.m)

[part1, part2] = partition(xy, L);

if picture == 1
    gplotpart(A, xy, part1);
    title('Inertial bisection using the Fiedler Eigenvector');
end


% <<<< Dummy implementation to generate a partitioning
% n   = size(A,1);
% map = zeros(n,1);
% map(1:round((n/2)))     = 0; 
% map((round((n/2))+1):n) = 1;
% 
% 
% [part1,part2] = other(map);
% 
% if picture == 1
%     gplotpart(A,xy,part1);
%     title('Inertial bisection (dummy) using the Fiedler Eigenvector');
% end
% Dummy implementation to generate a partitioning >>>>

end
