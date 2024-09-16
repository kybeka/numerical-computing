function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI


%  Add necessary paths
addpaths_GP;

% Graphs in question
% load 'helicopter.mat' ; 
% load 'skirt.mat';

% Steps
% 1. Initialize the cases

heli = load('helicopter.mat') ;
skirt = load('skirt.mat') ;

 ha = heli.Problem.A;
 hac = heli.Problem.aux.coord;

 sa = skirt.Problem.A;
 sac = skirt.Problem.aux.coord;

 p16 = 16;
 p32 = 32;



% 2. Call metismex to
%     a) Recursively partition the graphs in 16 and 32 subsets.
% helicopter
[r_heli_16, ec_rh16] = metismex('PartGraphRecursive', ha, p16);
[r_heli_32, ec_rh32] = metismex('PartGraphRecursive',ha, p32);

% skirt
[r_skirt_16, ec_rs16] = metismex('PartGraphRecursive', sa, p16);
[r_skirt_32, ec_rs32] = metismex('PartGraphRecursive', sa, p32);


%     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
% helicopter
[k_heli_16, ec_kh16] = metismex('PartGraphKWay', ha, p16);
[k_heli_32, ec_kh32] = metismex('PartGraphKWay', ha, p32);

% skirt
[k_skirt_16, ec_ks16] = metismex('PartGraphKWay', sa, p16);
[k_skirt_32, ec_ks32] = metismex('PartGraphKWay', sa, p32);

% 3. Visualize the results for 32 partitions
    
    % recursive
    disp(' Helicopter recursive p = 32 ...');
    gplotmap(ha, hac, r_heli_32);
    title(' Helicopter recursive p = 32 ...');
    rotate3d on;
    pause;

    disp(' Skirt recursive p = 32 ...');
    gplotmap(sa, sac, r_skirt_32);
    title(' Skirt recursive p = 32 ...');
    rotate3d on;
    pause;

    % k-way
    disp(' Helicopter k-way p = 32 ...');
    gplotmap(ha, hac, k_heli_32);
    title(' Helicopter k-way p = 32 ...');
    rotate3d on;
    pause;

    disp(' Skirt k-way p = 32 ...');
    gplotmap(sa, sac, k_skirt_32);
    title(' Skirt k-way p = 32 ...');
    rotate3d on;
    pause;
    
%     disp("ec_rh16  ec_rh32  ec_rs16  ec_rs32  ec_kh16  ec_kh32  ec_ks16  ec_ks32");
%     fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n', ec_rh16, ec_rh32,...
%     ec_rs16, ec_rs32, ec_kh16, ec_kh32, ec_ks16, ec_ks32);


end
