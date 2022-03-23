%% ------------------------------------------------------------------------
% Description: this value defines the value and the policy functions (i.e.
% optimal next period asset choice) for each time period. From the policy
% function we can work on the optimal consumption level.
% Note: the problem is solved by backwards recursion. The choice of the
% optimal level of savings is calculated in each period using 'fminbnd'
% which is a built-in optimizer in MatLab. It combines two methods: golden
% section search and parabolic interpolation.

function [ policyA1, policyC, V] = solveValueFunction

%% ------------------------------------------------------------------------
% Declare the variables we need
global T r tol minCons
global numPtsA Agrid
global V1 Agrid1       % tomorrow's value function and asset grid

%% ------------------------------------------------------------------------
% Generate matrices to store numerical approximations (of the computed
% policy and value functions). Note: set the dimension of output matrices
% equal to the number of periods x number of points in the asset grid.

V = NaN(T+1, numPtsA);
policyA1 = NaN(T, numPtsA);
policyC = NaN(T, numPtsA);

% Set the terminal value function to 0
V(T+1,:) = 0;

%% ------------------------------------------------------------------------
% Solve recursively the consumer's problem, starting at time T and moving
% backwards to zero one period at the time.

for ixt=T:-1:1                          % loop backwards from time T to 1
    V1 = V(ixt + 1,:);                  % tomorrow's value function at grid points
    Agrid1 = Agrid(ixt +1, :); % tomorrow's asset grid

    % Solve problem at grid points in assets
    for ixA = 1:1:numPtsA                % loop over points on asset grid
        
        % information for optimization
        A = Agrid(ixt, ixA);       % assets today
        lbA1 = Agrid1(1);          % assets tomorrow (lower bound)
        ubA1 = (A-minCons)*(1+r);     % assets tomorrow (upper bound)

        % compute solution
        if (ubA1 - lbA1 < tol)        % if liquidity constrained
            negV = objectivefunc(lbA1, A);
            policyA1(ixt,ixA) = lbA1;
        else 
            [policyA1(ixt,ixA),negV] = ...
                fminbnd(@(A1) objectivefunc(A1,A), lbA1, ubA1, optimset('TolX',tol));
        end % if (ubA1 - lbA1 < tol)

        % Store solution and its value
        policyC(ixt, ixA) = A - policyA1(ixt, ixA)/(1+r);
        V(ixt,ixA) = -negV;
    
    end %ixA
    
    fprintf('Passed period %d of %d. \n', ixt, T)	
end %ixt

end %function
