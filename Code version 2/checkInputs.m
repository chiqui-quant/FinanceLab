% This script checks that the various inputs have possible values and are compatible
% Check only one of solveUsingValueFunction and solveUsingEulerEquation

if (solveUsingValueFunction * solveUsingEulerEquation ~= 0 && solveUsingValueFunction + solveUsingEulerEquation  ~= 1)
    error('Exactly 1 of solveUsingValueFunction and solveUsingEulerFunction must be set equal to 1')
end

% Check inputs that need to be either 0 or 1 (in this case linearise)
if (linearise ~= 0) && (linearise ~=1)
    error('linearise should be either 0 or 1')
end
