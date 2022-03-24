% This function computes the inverse marginal utility (recovering consumption)
function [invmargut] = getinversemargutility (margut)

global gamma

% Invert marginal utility
if gamma == 1
    invmargut = 1./margut;
else
    invmargut = margut.^(-1/gamma);
end

end

