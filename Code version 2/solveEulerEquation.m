% Here we construct the value and policy functions (i.e. the optimal asset choice
% for the next period) for each time period. We solve the problem recursively 
% and backwards (as Jacopi would have said "Invert, always invert").
function [policyA1, policyC, V, dU] = solveEulerEquation

% We calculate the choice of the optimal level of savings in each period (solution to the
% Euler equation) using 'fzero' (which is a root-finding algorithm)
global T r tol minCons
global numPtsA Agrid linearise
global Agrid1 dU1 lindU1 V1     % tomorrow's asset grid, marginal utilities (dU), linearised dUs and value

%% ------------------------------------------------------------------------ 
% Generate matricises to store the numerical approximations
% Matrices to hold the policy, value and marginal utility functions.
% Note: set the dimension of output matrices equal ti the number of periods
% times the number of points in the assets grid.

V = NaN(T+1, numPtsA);
policyA1 = NaN(T, numPtsA);
policyC = NaN(T, numPtsA);        
dU = NaN(T, numPtsA);

% Note: if using quasi-linearization of the marginal utility to solve the Euler equation
% store the relevant section at t+1 in 'linDU1'
lindU1 = NaN(numPtsA,1);

% Set the terminal value function to 0
V(T+1,:) = 0;

%% ------------------------------------------------------------------------ 
% Solve the problem at time T (when the solution is known) 
% Note: optimal consumption equals total assets as there is no value to 
% keep them for after death.

for ixA = 1:1:numPtsA                            % points on asset grid
	% Information for optimization
    A = Agrid(T,ixA);                            % assets today

    % Compute and store solution and its value
    policyC(T,ixA)  = A;                         % optimal consumption
    policyA1(T,ixA) = 0;                         % optimal savings
    V(T,ixA)  = utility(policyC(T,ixA));         % value of consumption
    dU(T,ixA) = getmargutility(policyC(T,ixA));  % marginal value of consumption
    
end %ixA
fprintf('Passed period %d of %d.\n',T, T) % this prints in the consol the dates that are computed

%% ------------------------------------------------------------------------ 
% SOLVE RECURSIVELY THE CONSUMER'S PROBLEM, BACKWARDS FROM T-1 TO ZERO

for ixt=(T-1):-1:1                         % Loop from time T-1 to 1
    
    Agrid1 = Agrid(ixt + 1, :);            % The grid on assets tomorrow
    dU1 = dU(ixt + 1,:);                   % relevant section of dU matrix (in assets tomorrow)
    V1  = V(ixt + 1,:) ;                   % relevant section of V matrix (in assets tomorrow)
    
    % solve problem for each grid point in assets today
    for ixA = 1:1:numPtsA                  % Loop through points on the asset grid

        % Information for optimisation
        A    = Agrid(ixt, ixA);            % assets today
        lbA1 = Agrid1(1);                  % lower bound: assets tomorrow
        ubA1 = (A - minCons)*(1+r);        % upper bound: assets tomorrow
        bndForSol = [lbA1, ubA1];          % if the Euler equation has a soluton it will be within these bounds
        if linearise == 1                  % get 'linearised' marginal utility tomorrow
        	lindU1 = getinversemargutility(dU1); %this is to recover consumption from marg utility
        end
           
        % Compute solution 
        signoflowerbound = sign(eulerforzero(A, lbA1));        % = 1 if positive
        if (signoflowerbound == 1) || (ubA1 - lbA1 < tol)      % if liquidity constrained (wants to consume everything today)
        	policyA1(ixt, ixA) = lbA1;
        else                                                   % if interior solution                              
        	signofupperbound = sign(eulerforzero(A, ubA1));
            if (signoflowerbound*signofupperbound == 1)        % wants to postpone all consumption
            	error('Sign of lower bound and upperbound are the same - no solution to Euler equation. Bug likely.')
            end
            [policyA1(ixt, ixA)] = fzero(@(A1) eulerforzero(A, A1), bndForSol, optimset('TolX',tol));
        end

        % Store solution and its value
        policyC(ixt,ixA) = A - policyA1(ixt, ixA)/(1+r);        
        dU(ixt,ixA)      = getmargutility(policyC(ixt, ixA));
        V(ixt,ixA)       = -objectivefunc(policyA1(ixt, ixA), A);

    end %ixA

    fprintf('Passed period %d of %d.\n',ixt, T)
   
end %ixt

end
