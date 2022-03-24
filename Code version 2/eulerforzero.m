% This function returns u'(c_t) - b(1+r)u'(c_t+1)
% Note: this quanty is 0 if the Euler equation u'(c_t) = b(1+r(u'(c_t+1) is satisfied at c_t

function [euler] = eulerforzero(A0,A1)

global r beta interpMethod
global dU1 lindU1 linearise
global Agrid1

% Get marginal utility of tomorrow's consumption
if linearise == 0
    duAtA1 = interp1(Agrid1, dU1, A1, interpMethod, 'extrap');
elseif linearise == 1
    invDuAtA1 = interp1(Agrid1, lindU1, A1, interpMethod, 'extrap');
    duAtA1    = getmargutility(invDuAtA1);
end    

% Check if tomorrow's expected marginal utility is negative (in that case throw an error)
if (duAtA1 < 0)    
   error('Approximated marginal utility in negative')
end

% Get consumption today and the required output
todaycons = A0 - A1/(1+r);
euler     = getmargutility(todaycons) - (beta * (1+r) * duAtA1) ;

end
