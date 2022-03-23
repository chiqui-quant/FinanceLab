% ---------------------------------------------------------
% Description: this function returns the minimum and maximum on the asset
% grid in each year. The minimum is the natural borrowing constraint. The
% maximum is how much one would have by saving everything.

function [ BC, maxA ] = getMinAndMaxAss(startA)

%% ---------------------------------------------------------
% Declare the global variables we need in this file
global T r minCons

%% ------------------------------------------------------------------------
% Initialize the output matrices
BC = NaN(T+1,1);
maxA = NaN(T+1,1);

%% ------------------------------------------------------------------------
% Here we iteratively calculate the borrowing constraints and maximum on
% the asset grid

% Borrowing constraints
BC(T+1) = 0;
for ixt = T:-1:1
    BC(ixt) = BC(ixt+1)/(1+r) +minCons;
end

% Maximum assets
maxA(1) = startA;
for ixt = 2:1:T+1
    maxA(ixt) = (maxA(ixt -1)) * (1+r);
end

end
