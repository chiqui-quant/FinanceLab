% Life Cycle Models. 
% Code originally written by Monica Costa Dias and Cormac O'Dea
% Edited by Francesca Parodi, January 2022
% Re-edited by Chiqui, March 2022

% Note: this time we have to approaches to solve the problem (and find the 
% optimal policy for each period)
% 1. Use an algorithm to find the maximum of the value function
% 2. Solve analytically using the first order conditions (Euler equation)

% Note: before running the program we clear memory to avoid conflicts

tic;        % start the clock
clear all;  % clear memory
close all;  % close any graphs

global beta gamma r T        % model parameters
global Agrid numPtsA         % asset grid and dimension (number of points)
global interpMethod linearise    % numerical methods
global tol minCons           % numerical constants
global plotNumber            % for plotting stuff

%% ------------------------------------------------------------------------ 
% Numerical methods (select the type of solution and interpolation method)
interpMethod = 'pchip';              % methods: linear, nearest, spline, pchip
solveUsingValueFunction = 0;         % set to 1 to solve using the value function (else 0)
solveUsingEulerEquation = 1;    % set to 1 to solve using Euler equation (else 0)
linearise = 0;                       % linearize the slope of EV when using EE or not (1 or 0)

%% ------------------------------------------------------------------------ 
% Numerical constants (needed for numerical solution and simulation)
% Precision parameters
tol = 1e-10;                         % max allowed error (tolerance) 
minCons = 1e-5;                      % min allowed consumption (it cannot be zero)

%% ------------------------------------------------------------------------ 
% Economic environment (structural economic parameters and initial values for simulations)
T = 80;                       % number of time periods
r = 0.01;                     % interest rate
beta = 1/(1+r);               % discount factor
gamma = 1.5;                  % coefficient of relative risk aversion
startA = 1;                   % starting amount of assets for the individual

%% ------------------------------------------------------------------------ 
% Grids for assets (choose the dimension and select the methods to construct grids)
numPtsA = 20;                 % number of points in the discretized asset grid
gridMethod = '5logsteps';      % methods: equalteps, logsteps, 3 or 5 or 10logsteps

%% ------------------------------------------------------------------------ 
% Check the inputs
checkInputs;

%% ------------------------------------------------------------------------ 
% Populate the grid for assets using 'gridMethod'
[ MinAss, MaxAss ] = getMinAndMaxAss(startA);

Agrid = NaN(T+1, numPtsA);
for ixt = 1:1:T+1
    Agrid(ixt, :) = getGrid(MinAss(ixt), MaxAss(ixt), numPtsA, gridMethod);
end

%% ------------------------------------------------------------------------ 
% Solve the consumption problem (get policy and value functions)
if solveUsingValueFunction == 1
    [ policyA1, policyC, val, dU ] = solveValueFunction;
elseif solveUsingEulerEquation == 1
    [ policyA1, policyC, val, dU ] = solveEulerEquation;
end


%% ------------------------------------------------------------------------ 
% Simulate consumer's paths (start from the initial level of assets and
% simulate optimal consumption and savings profiles over the lifecycle)
[ cpath, apath, vpath ] = simNoUncer(policyA1, val, startA);

%% ------------------------------------------------------------------------ 
% Plot paths of consumption, income and assets
plotNumber = 0;
plotApath(apath)
plotCpath(cpath)
plotCZoomedOut(cpath)

% Plot value and policy functions
whichyear = 1;
plotNode1 = 1;
plotNodeLast = numPtsA; 
plotV;

%% ------------------------------------------------------------------------ 
% Get the analytical policy functions if there is no uncertainty and borrowing 
% is allowed. Analytic solution:
[policyA1_analytic, policyC_analytic] = getPolicy_analytical;

% Get the ratio of the numerical policy function to analytic policy functions 
% (for comparison)
ratioOfPolicyC = policyC./policyC_analytic;
ratioOfPolicyA = policyA1./policyA1_analytic;

% Plot the value and policy functions
whichyear = 1;
plotNode1 = 3;
plotNodeLast = numPtsA - 2; 
plotNumericError;

toc;     % Stop the clock
































