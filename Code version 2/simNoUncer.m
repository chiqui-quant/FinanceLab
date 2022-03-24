% Here we take the starting assets, the policy function and the value function
% and we simulate the paths of consumption, assets and value function
% (in an environment without uncertainty)

function [c,a,v] = simNoUncer(policyA1, V, startA)

global T r
global Agrid interpMethod

% Initialize the arrays that will hold the paths of income consumption, assets
% and value. Arguments for output:
c = NaN(T, 1);     % consumption
v = NaN(T, 1);     % value
a = NaN(T+1, 1);   % path at the start of each period (we assume the 'start' as the death date)

% Obtain the paths using the initial condition and the policy and value functions
a(1, 1) = startA;   
for t = 1:1:T                     % loop through time periods for a particular individual
    v(t  , 1) = interp1(Agrid(t, :), V(t, :), a(t, 1), interpMethod, 'extrap');                               
    a(t+1, 1) = interp1(Agrid(t, :), policyA1(t, :), a(t, 1), interpMethod, 'extrap');        
    c(t  , 1) = a(t, 1)  - (a(t+1, 1)/(1+r));
end   %t      
 
end