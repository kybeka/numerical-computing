function x = pagerank1(U,G,p)

if nargin < 3, p = .85; end

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

e = ones(n,1);
% I = speye(n,n);

% ---------------------------------- DEFAULT ------------------------------
% Solve (I - p*G*D)*x = e
disp('Using power method\n');
% count = 0;
A = p * G * D;
z = ((1-p) * (c~=0) + (c==0)) / n ;
x = e / n ;

prevx = zeros (n , 1) ;
% we set the limit at 10^-5
limit = 0.00001;

while norm(x-prevx) > limit
    prevx = x ;
    x = A * x + e * (z * x);
    % count = count + 1
end
% disp("count: " + count);
% -------------------------------------------------------------------------

% Normalize so that sum(x) == 1.
x = x/sum(x);

% Bar graph of page rank.
shg
bar(x)
title('Page Rank')

% Print URLs in page rank order.

if nargout < 1
   [~,q] = sort(-x);
   disp('     page-rank  in  out  url')
   k = 1;
   maxN = length(U);
   while  (k <= maxN) && (x(q(k)) >= .005)
       disp(k)
      j = q(k);
      temp1  = r(j);
      temp2  = c(j);
      disp(fprintf(' %3.0f %8.4f %4.0f %4.0f  %s', j,x(j),full(temp1),full(temp2),U{j}))
      k = k+1;
   end
end
