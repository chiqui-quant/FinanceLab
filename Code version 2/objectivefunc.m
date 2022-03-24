% This function returns -(u(c) + b V(A1))
% where c is calculated from today's assets and tomorrow's assets (with linear interpolation)
function [value] = objectivefunc(A1,A0)

global beta r interpMethod   % model parameters
global Agrid1 V1             % tomorrow's asset grid and value function

% Get tomorrow's consumption (cons), the value of remaining assets (VA1) and
% the total value (u(c) + beta * VA1)
cons  = A0  - (A1)/(1+r);
VA1   = interp1(Agrid1, V1, A1, interpMethod, 'extrap');
value = utility(cons) + beta * VA1;

% The optimization that we use searches for the minimum of the function. To get the maximum
% multiply the function by -1.
value = - value;
end
