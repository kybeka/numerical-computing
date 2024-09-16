function [Spec_nodes,Kmeans_nodes] = ClusterMetrics(K,x_spec,x_kmeans)
%% METRICS
Spec_nodes   = zeros(K,1);
Kmeans_nodes = zeros(K,1);

 % 2c) Calculate the number of nodes per cluster (for k-means and spectral
 %     clustering) and plot them in a histogram.
 
 for i = 1:K
     Spec_nodes(i) = sum(x_spec == i);
     Kmeans_nodes(i) = sum(x_kmeans == i);
 end

figure;
subplot(1,2,1);
bar(Spec_nodes,'BarWidth',1);
xlabel('Clusters');
ylabel('Nodes');
title('Spectral Histogram');

subplot(1,2,2);
bar(Kmeans_nodes,'BarWidth',1);
xlabel('Clusters');
ylabel('Nodes');
title('K-means Histogram');
