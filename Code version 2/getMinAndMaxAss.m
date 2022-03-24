% Here we return the minimum and maximum on the asset grid for each year. The minimum
% is the natural borrowing constraint. The maximum is how much one would have if saving
% everything (conditional on the initial assets)

function [BC,maxA] = getMinAndMaxAss(startA)

global T r minCons

% Initialize the output matrices
BC = NaN(T+1, 1);
maxA = NaN(T+1, 1);

% Iteratively, calculate the borrowing constraints and maximum on asset
% grid. Borrowing constraints: 
BC(T + 1) = 0;
for ixt = T:-1:1
    BC(ixt) = BC(ixt+1)/(1+r) + minCons ;
end

% Maximum Assets
maxA(1) = startA;
for ixt = 2:1:T+1
    maxA(ixt) = maxA(ixt-1) * (1+r);
end

   
end
