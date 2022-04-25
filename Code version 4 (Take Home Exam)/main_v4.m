%% ------------------------------------------------------------------------ 
% Life Cycle Models v4 (take home exam by Sposato Christian) 
% Code originally written by Monica Costa Dias and Cormac O'Dea
% Edited by Francesca Parodi, January 2022
% Re-edited by Sposato Christian, April 2022
% Note: variable names have been kept unchanged for ease of correction

% ------------------------------------------------------------------------- 
% DESCRIPTION
% This program solves and simulates a finite period consumption and savings 
% problem. It allows for uncertainty in income. We assume a very basic
% form of uncertainty, where income can take a discrete set of values. 
% These income values and their probability distribution are to be 
% hardcoded by the user.
%
% The consumer starts her life with an endowmnent of assets and receives a 
% stream of random income shocks, one in each period or her life. In each 
% period she chooses how to allocate her total budget to consumption and 
% savings. 
%
% The problem is solved by backward induction. It uses one of two options 
% to select the optimal policy in each period: a search algorithm to locate 
% the maximum of the value function or it the solves for the first order 
% conditions (Euler equation).

%% ------------------------------------------------------------------------ 
% PREAMBLE
% Make sure that all storage spaces variables, matrices, memory, globals are 
% clean from information stored in past runs in order to avoid possible
% issues.

tic;        % start the timer (useful for checking code efficiency)
clear all;  % clear memory and all variables
close all;  % close any graphs


%% ------------------------------------------------------------------------ 
% DECLARE VARIABLES AND MATRICES THAT WILL BE 'GLOBAL'
% These are the variables that are needed and shared across the different
% functions we will use.

global beta gamma r T Tretire           % structural model parameters 
global numPtsA Agrid                    % assets grid and its dimension
global numPtsY Ygrid incTransitionMrx   % income grid, dimension, and transition matrices (1)
global hcIncome hcIncPDF                % income grid, dimension, and transition matrices (2)
global interpMethod linearise           % different numerical methods
global tol minCons numSims              % numerical constants
global plotNumber                       % for plotting (display graphs)


%% ------------------------------------------------------------------------ 
% NUMERICAL METHODS
% Select solution, interpolation and integration methods

interpMethod = 'pchip';      % possible interpolation methods: 'linear', 'nearest', 'spline', 'pchip'
solveUsingValueFunction = 1; % set to 1 to solve using value function (else = 0)
solveUsingEulerEquation = 0; % set to 1 to solve using Euler equation (else = 0)
linearise = 1;               % whether to linearise the slope of EV when using EE (set linearise=1 to do this, else = 0)


%% ------------------------------------------------------------------------ 
% NUMERICAL CONSTANTS
% Here we set the constants needed for the numerical solution and
% simulation

% Precision parameters
tol = 1e-10;                 % max allowed error (not 0, otherwise there can be computation errors)
minCons = 1e-5;              % min allowed consumption

% Information for simulations
numSims = 10;                % How many individuals to simulate (10 agents required in the assignment)


%% ------------------------------------------------------------------------ 
% THE ECONOMIC ENVIRONMENT
% Here we set values of structural economic parameters

T = 40;                      % Number of time period
Tretire = 30; % (alternatively T-10 as required) % Age at of retirement
r = 0.01;                    % Interest rate
beta = 0.95;                 % Discount factor
gamma = 1.5;                 % Coefficient of relative risk aversion (CRRA)
borrowingAllowed = 1;        % Whether borrowing is allowed (set 1 to allow borrowing)
startA = 0;                  % Starting amount of assets for the individuals

%% ------------------------------------------------------------------------ 
% GRIDS
% Choose dimensions, set matrices and select the methods to construct grids

% Grid for assets
numPtsA = 20;                % number of points in the discretised asset grid
gridMethod = '10logsteps';   % choose between: equalsteps, logsteps, 3logsteps, 5logsteps or 10logsteps

% Grid for income shocks
numPtsY = 4;                 % points in grid for income (4 points required by the assignment)
hcIncome = [2.1, 2.8, 3.4, 3.9]';   % hard-coded shocks
hcIncPDF = [0.3, 0.2, 0.2, 0.3]';   % respective probabilities (they must sum up to 1)


%% ------------------------------------------------------------------------ 
% Check inputs
checkInputs;


%% ------------------------------------------------------------------------ 
% GET INCOME GRID
[Ygrid, incTransitionMrx, minInc, maxInc] = getIncomeGrid;


%% ------------------------------------------------------------------------ 
% GET ASSET GRID
% Populate the grid for assets using 'gridMethod'
% Populate matrix borrowCon and maxAss, which store the bounds for assets

[ borrowCon, maxAss ] = getMinAndMaxAss(borrowingAllowed, minInc, maxInc, startA);

Agrid = NaN(T+1, numPtsA);
for ixt = 1:1:T+1
    Agrid(ixt, :) = getGrid(borrowCon(ixt), maxAss(ixt), numPtsA, gridMethod);
end


%% ------------------------------------------------------------------------ 
% SOLVE CONSUMER'S PROBLEM
% Get policy function and value function 

if solveUsingValueFunction == 1
    [ policyA1, policyC, val, exVal, exDU ] = solveValueFunction;
elseif solveUsingEulerEquation == 1
    [ policyA1, policyC, val, exVal, exDU ] = solveEulerEquation;
end


%% ------------------------------------------------------------------------ 
% SIMULATE CONSUMER'S PATHS
% Start from the initial level of assets and simulate optimal consumption and
% savings profiles over the lifecycle

[ ypath, cpath, apath, vpath ] = simWithUncer(policyA1,exVal, startA);


%% ------------------------------------------------------------------------ 
% PLOTS
% Plot paths of consumption, income and assets 

% IMPORTANT NOTES
% (1) plotYAndCpaths and plotYCandApaths were not plotting for
% each agent, to solve the issue I modified the original functions by calling 
% the variable numSims and creating a for loop in order to correctly plot 
% for each individual. 
% (2) I also added 'Location','best' so the plot legend
% doesn't interfere and makes it easier to interpret the final part of the
% graph.
% (3) When running the code with more than 2 agents, plotApath still showed
% the label for only two agents. I adjusted it such that it correctly
% displays the color for the corresponding individual and now it works also
% for any value of numSims. It is possible also to show the label for the
% green dotted line by appending it (see plotApath.m).
% (4) As requested plotSln.m now displays the 4 policy consumption
% functions (one for each of the 4 income shocks). Differently from the
% previous points, the method has not been generalized so that one might
% have to change the values of 'Grid for income shocks' manually and adapt
% the plotting functions. Since the value function was not required
% in the assignment, I commented it in the function file, however I still 
% adapted it such that it works with the 4 income shocks (if you run it
% zoom a little bit to better distinguish each value function since they
% are pretty close).
% (5) I have initially misread point (g) of the assignment. I thought it was
% requested to plot the mean of the value function across all individuals,
% since I did it anyway and doesn't affect the scope of the exam and is
% just an addition I will leave it like that. Differently from point
% (3), I have chosen to prioritize and emphasize the mean by plotting it first
% Note: this time the legend displays all values but instead of
% 'individuals' they are called 'data n' by default. This is an alternative
% way which circumnavigates the previous issue, without the need of
% installing the 'legendappend' package.
% (6) Finally as requested in point (g) by using the script plotMean.m I
% report on the same graph the mean simulated consumption and assets (where 
% the mean is taken across all 10 simulated agents).

plotNumber = 0;
plotVpath(vpath)            % simulated value function over the course of life
plotApath(apath,borrowCon)  % simulated path of assets over life
plotYAndCpaths(ypath,cpath); % simulated paths of consumption and income over life
plotYCAndApaths(ypath,cpath,apath); % simulated paths of assets, consumption and income

% Plot value and policy functions (parameters)
whichyear = 20;          % time period for the assignment is 20
plotNode1 = 1;           % plot node corresponding to each time period
plotNodeLast = numPtsA; 
plotSln;                 % plot policy and value functions against assets
plotMean;                % plot mean simulated consumption and assets

toc;     % Stop the timer
% ------------------------------------------------------------------------ 
% ------------------------------------------------------------------------