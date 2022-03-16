%% ------------------------------------------------------------------------
% Description: this value defines the value and the policy functions (i.e.
% optimal next period asset choice) for each time period. From the policy
% function we can work on the optimal consumption level.
% Note: the problem is solved by backwards recursion. The choice of the
% optimal level of savings is calculated in each period using 'fminbnd'
% which is a built-in optimizer in MatLab. It combines two methods: golden
% section search and parabolic interpolation.

function [ policy_A1, policy_C, V] = solve_value_function

%% ------------------------------------------------------------------------
% Declare the variables we need
global T r tol min_const
global num_pts_assetgrid
global V1 assetgrid1       % tomorrow's value function and asset grid

%% ------------------------------------------------------------------------
% Generate matrices to store numerical approximations (of the computed
% policy and value functions). Note: set the dimension of output matrices
% equal to the number of periods x number of points in the asset grid.

V = NaN(T+1, num_pts_assetgrid);
policy_A1 = NaN(T, num_pts_assetgrid);
policy_C = NaN(T, num_pts_assetgrid);

% Set the terminal value function to 0
V(T+1,:) = 0;

%% ------------------------------------------------------------------------
% Solve recursively the consumer's problem, starting at time T and moving
% backwards to zero one period at the time.

for ixt=T:-1:1                          % loop backwards from time T to 1
    V1 = V(ixt + 1,:);                  % tomorrow's value function at grid points
    assetgrid1 = assetgrid1(ixt +1, :); % tomorrow's asset grid

    % Solve problem at grid points in assets
    for ixA = 1:1:num_pts_assetgrid % loop over points on asset grid
        
        % information for optimization
        A = asset_grid(ixt, ixA);       % assets today
        lb_A1 = assetgrid1(1);          % assets tomorrow (lower bound)
        ub_A1 = (A-min_const)*(1+r)     % assets tomorrow (upper bound)

        % compute solution
        if (ub_A1 - lb_A1 < tol)        % if liquidity constrained
            neg_V = objectivefunc(lb_A1, A);
            policy_A1(ixt,ixA) = lb_A1;
        else 
            [policy_A1(ixt,ixA),neg_V] = ...
                fminbnd(@(A1) objectivefunc(A1,A), lb_A1, ub_A1, optimset('TolX',tol));
        end % if (ub_A1 - lb_A1 < tol)