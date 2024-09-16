% Cluster 2D pointclouds with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing 

clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes

% Specify the number of clusters
K = 4;

%% 1.1) Get coordinate list from pointclouds
% Coords used in this script

% Pts_halfkernel = [rand(1,100)*5;rand(1,100)*5]';
% title('TODO: Get the coordinate list from the function getPoints.m')
% dummy vars
% dummy_map     = ones(n,1);
% dummy_epsilon = 1;

Pts_halfkernel = halfkernel();
% Pts_halfkernel = outlier();

figure;
scatter(Pts_halfkernel(:,1),Pts_halfkernel(:,2))
title('Graph');

n = size(Pts_halfkernel,1);

% Create Gaussian similarity function
[S] = similarityfunc(Pts_halfkernel(:,1:2), 7);
% playing around with the value

%% 1.2) Find the minimal spanning tree of the full graph. Use the information to determine a valid value for epsilon        
% returns the distance between each pair X, Y
G = pdist2(Pts_halfkernel, Pts_halfkernel);
A = double(G < max(G(:)));

min_span_tree = minSpanTree(A);
eps = max(min_span_tree(min_span_tree > 0));

sparse_mst = sparse(min_span_tree);
graph_mst = graph(sparse_mst);

% Graph it:
figure;
plot(graph_mst, 'XData',Pts_halfkernel(:, 1), 'YData', Pts_halfkernel(:, 2));
title('Minimal Spanning Tree of Graph');

%% 1.3) Create the epsilon similarity graph
[G] = epsilonSimGraph(eps, Pts_halfkernel);

%% 1.4) Create the adjacency matrix for the epsilon case 
% W = rand(n,n);

W = S .* G;

figure;
gplotg(W, Pts_halfkernel(:,1:2))
title('Adjacency matrix')
%% 1.5) Create the Laplacian matrix and implement spectral clustering
[L, Diag] = CreateLapl(W);
% Extract
[eigs, eigvals] = eig(L);
% K smallest eigenvalues of the resulting Laplacian matrix
[~, id_eig] = sort(diag(G));
% K-smallest eigval's
V = eigs(:,id_eig(1:K));
% of the corresponding eigenvectors
% V normalized
V_norm = diag(1./sqrt(sum(V.^2, 2))) * V;

% Cluster rows of eigenvector matrix of L corresponding to K smallest
% eigennalues. Use kmeans for that.
[D_spec, x_spec] = kmeans_mod(V_norm, K, n);

%% 1.6) Run K-means on input data
[D_kmeans, x_kmeans] = kmeans_mod(Pts_halfkernel,K,n);

%% 1.7) Visualize spectral and k-means clustering results
figure;
subplot(1,2,1)
gplotmap(W, Pts_halfkernel, x_spec)
title('Spectral clusters')

subplot(1,2,2)
gplotmap(W, Pts_halfkernel, x_kmeans)
title('K-means clusters')