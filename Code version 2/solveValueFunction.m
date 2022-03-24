% Here we construct the value and policy functions for each time period.
% This second approach solves by using 'fminbnd' (a built-in optimizer in Matlab) that 
% combines two methods 'golden section search' and 'parabolic interpolation'.

function [policyA1, policyC, V, dU] = solveValueFunction

global T r tol minCons
global numPtsA Agrid
global V1 Agrid1

%% ------------------------------------------------------------------------ 
% Generate matrices to store numerical values (value, policy and marginal utility functions)
V        = NaN(T+1, numPtsA);
policyA1 = NaN(T,   numPtsA);
policyC  = NaN(T,   numPtsA);        
dU       = NaN(T,   numPtsA);        

% Set the terminal value function to 0
V(T+1,:) = 0;

%% ------------------------------------------------------------------------ 
% Solve recursively, starting at time T and moving backwards to zero (one period at the time)
for ixt=T:-1:1                                           % loop (in single steps) from T to 1
    V1 = V(ixt + 1, :);                                  % get tomorrow's value function
    Agrid1 = Agrid(ixt + 1, :);                          % get tomorrow's asset grid 

    % Solve the problem for each grid point (numPtsA)
    for ixA = 1:1:numPtsA
        % Information for the optimization
        A = Agrid(ixt, ixA);                             % loop for the points in the asset grid
        lbA1 = Agrid(1);                                 % assets tomorrow (lower bound)
        ubA1 = (A - minCons)*(1+r);                      % assets tomorrow (upper bound)

        % Compute solution
        if (ubA1 - lbA1 < tol)                           % if liquidity constrained
            negV = objectivevaluefunc(lbA1, A);
            policyA1(ixt, ixA) = lbA1; 
        else                                             % if interior solution
            [policyA1(ixt, ixA), negV] = ...
                fminbnd(@(A1) objectivefunc(A1, A), lbA1, ubA1, optimset('TolX',tol));
        end % if (ubA1 - lbA1 < tol)

        % Store solution, its value and the marginal utility of optimal consumption
        policyC(ixt, ixA) = A - policyA1(ixt, ixA)/(1+r);
        V(ixt, ixA) = - negV;
        dU(ixt, ixA) = getmargutility(policyC(ixt, ixA)); % (not necessary, but interesting to look at)

    end %ixA (Note: ixA = 'for each A')

    fprintf('Passed period %d of %d.\n',ixt,T)
end % ixt (Note: ixt = 'for each time period t')

end % function


