% Cluster 2D real-world graphs with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing 

clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes

load airfoil1.mat
% load barth.mat
% load grid2.mat
% load 3elt.mat

% Specify the number of clusters
K = 4;
% Read graph
W   = Problem.A;
Pts = Problem.aux.coord;
n   = size(Pts,1);

figure;
spy(W)
title('Adjacency matrix')
%% 2.1) Create the Laplacian matrix and plot the graphs using the 2nd and 3rd eigenvectors
L = CreateLapl(W);
L = sparse(L);

% Eigen-decomposition
[eigvecs, ~] = eigs(L, 3, 'SA');

eig2 = eigvecs(:,2);
eig3 = eigvecs(:,3);

xy_coords = Pts;
spec_coords = [eig2,eig3];


% Plot and compare
figure;
subplot(1, 2, 1);
gplot(W, xy_coords)
xlabel('Nodal coordinates')

subplot(1, 2, 2);
gplot(W, spec_coords)
xlabel('Eigenvector coordinates')

%% 2.2) Cluster each graph in K = 4 clusters with the spectral and the 
%      k-means method, and compare yourresults visually for each case.

adj_spec = W;
adj_kmean = W;

spec_clusters = kmeans([eig2,eig3], K);
kmean_clusters = kmeans(Pts, K);

for i = 1:n
    for j = i+1:n 
        if spec_clusters(i) ~= spec_clusters(j)
            adj_spec(i, j) = 0;
            adj_spec(j, i) = 0;
        end
        if kmean_clusters(i) ~= kmean_clusters(j)
            adj_kmean(i, j) = 0;
            adj_kmean(j, i) = 0; 
        end
    end
end

cmap = lines(K);

% Compare and visualize

figure;
subplot(1,2,1);
gplotmap(W, Pts, spec_clusters)
title('Plot of the spectral clusters')


subplot(1,2,2);
gplotmap(W, Pts, kmean_clusters)
title('Plot of the K-means clusters')

%% 2.3) Calculate the number of nodes per cluster
[spec_nodes, kmeans_nodes] = ClusterMetrics(K, spec_clusters, kmean_clusters);

