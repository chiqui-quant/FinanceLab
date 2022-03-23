% This function takes consumption as an argument and returns utility.
% The utility function is CRRA (Constant Relative Risk Aversion)
function [utils] = utility (cons)

global gamma

			   % Check for errors and return error message
if cons<=0
  error('Error in utility. Consumption is <=0');
end

		    % Calculate utility of consumption (assuming CRRA)
if  gamma == 1
  utils = log(cons);
else
  utils = ((cons)^(1-gamma)) / (1-gamma); 
end

end
