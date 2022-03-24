% Same function as in "Code version 1"

function [grid] = getGrid(minongrid, maxongrid, GridPoints, method)

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
