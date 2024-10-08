close all;
clear;
clc;

type = 'max';
A = [1   0   0   0   1   0   0   0   1   0   0   0   1   0   0   0;
     0   1   0   0   0   1   0   0   0   1   0   0   0   1   0   0;
     0   0   1   0   0   0   1   0   0   0   1   0   0   0   1   0;
     0   0   0   1   0   0   0   1   0   0   0   1   0   0   0   1;
     320 0   0   0   510 0   0   0   630 0   0   0   125 0   0   0;
     0   320 0   0   0   510 0   0   0   630 0   0   0   125 0   0;
     0   0   320 0   0   0   510 0   0   0   630 0   0   0   125 0;
     0   0   0   320 0   0   0   510 0   0   0   630 0   0   0   125;
     1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0;
     0   0   0   0   1   1   1   1   0   0   0   0   0   0   0   0;
     0   0   0   0   0   0   0   0   1   1   1   1   0   0   0   0;
     0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1];

h = [18; 32; 25; 17; 11930; 22552; 11209; 5870; 16; 32; 40; 28];

c = [135, 148.5, 162, 175.5, 200, 220, 240, 260, 410, 451, 492, 533, 520, 572, 624, 676];

sign = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1; -1];

[z,x_B,index_B] = simplex(type,A,h,c,sign);