% Credit: this code borrows from Chris Carroll of Johns Hopkins University. His website is
% http://www.econ2.jhu.edu/people/ccarroll/ and you can find his notes on solving dynamic
% models at http://www.econ2.jhu.edu/people/ccarroll/SolvingMicroDSOPs.pdf

function [grid] = getGrid(minongrid, maxongrid, GridPoints, method)

%% Description
% This function constructs a grid from 'minongrid' to 'maxongrid' with 'GridPoints' and using
% 'method' (equalteps, logsteps, 3logsteps, 5logsteps or 10logsteps)

% We need to construct a grid from a to b. The following line spaces out the points equally
% grid = linspace (a,b, GridPoints);

% We can also equally space out the grid points in logs 
% grid = exp(linspace(log(a), log(b), GridPoints));
% Note: this doesn't work when a<=0. In our case we want to get an equally spaced out grid
% from log(1) to log(b - a +1), exponentiate each point and subtract 1 to form a grid from 0 to b-a.% Then we add a to each point to obtain a log-spaced grid from a to b.

%% -------------------------------------------- ---------------------------- 

span = maxongrid - minongrid;     % b - a                  

if strcmp(method, 'equalsteps')
    grid= linspace(0, span, GridPoints);
    
elseif strcmp(method, 'logsteps')
  loggrid = linspace(log(1), log(1+span), GridPoints);
  grid = exp(loggrid)-1;
  
elseif strcmp(method, '3logsteps')
  loggrid = linspace(log(1+log(1+log(1))), log(1+log(1+log(1+span))), GridPoints);
  grid = exp(exp(exp(loggrid)-1)-1)-1;   
  
elseif strcmp(method, '5logsteps')
  loggrid = linspace(log(1+log(1+log(1+log(1+log(1))))), ...
                     log(1+log(1+log(1+log(1+log(1+span))))), GridPoints);
  grid = exp(exp(exp(exp(exp(loggrid)-1)-1)-1)-1)-1;   
  
elseif strcmp(method, '10logsteps')
  loggrid = linspace(log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1)))))))))), ...
                     log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1+log(1+span)))))))))), GridPoints);
  grid = exp(exp(exp(exp(exp(exp(exp(exp(exp(exp(loggrid)-1)-1)-1)-1)-1)-1)-1)-1)-1)-1;   
  
else
    error('Error in getgrid. You have entered an invalid method for choosing the distance between grid points. Method must be one of equalsteps, logsteps, 3logsteps, 5logsteps or 10logsteps.');
end

grid = grid + minongrid*ones(1, GridPoints);

end




















