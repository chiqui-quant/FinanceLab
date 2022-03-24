% Here we compute the utility function, assuming CRRA (constant relative risk aversion)
function [utils] = utility (cons)

global gamma

% Check for errors and return error message
if cons<= 0
    error('Ups, consumption is negative :(');
end

% Calculate the utility gained by consumption (assuming CRRA)
if gamma == 1
    utils = log(cons);
else 
    utils = ((cons)^(1-gamma)) / (1-gamma);
end

end



