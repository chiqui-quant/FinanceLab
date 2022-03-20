%% ------------------------------------------------------------------------ 
% Life Cycle Models. 
% Code originally written by Monica Costa Dias and Cormac O'Dea
% Edited by Francesca Parodi, January 2022
% Re-edited by Chiqui, March 2022

%% -------------------------------------------------------------------- 
% DESCRIPTION
% Goal: solve and simulate a finite period consumption and saving problem
% (a.k.a. cake eating problem). Setting: there is no income or
% uncertainty. The consumer starts with an endowment of assets and chooses
% how to allocate consumption over time in order to maximize his utility.
% We solve this by backward induction using a search algorithm to locate
% the choice that maximizes the value function in each period.

%% IMPORTANT
% Make sure all variables and memory are clean from information stored in
% past runs in order to avoid conflict or potential bugs.

tic; % this starts counting the running time of the code (facultative)
clear all; % clears memory
close all; % closes any graphs

%% DECLARE VARIABLES and MATRICES that will be 'GLOBAL' 
% declare the variables and matrices that are needed from or for other files

global beta gamma r T	 % our model parameters (note: you can write them spaced like this)
global numPtsA Agrid	 % assets grid and dimension
global interpMethod	 % numerical interpolation method used
global tol minCons 	 % numerical constants
global plotNumber	 % for plotting the result

%% Numerical methods
% Select solution, interpolation and integration methods. 
% Interpolation method: 'linear', 'nearest', 'spline', 'pchip'
% Note 1: spline and pchip use piecewise cubic polynomials (pchip is shape
% preserving)
% Note 2: linear is the default option. 

interpMethod = 'linear';

%% Numerical constants
% Here we set the constants needed for the numerical solution and
% simulation

tol = 1e-10;    % max allowed error
minCons = 1e-5; % max allowed consumptionà

%% The economic environment
% Here we set the values of structural economic parameters and initial
% values for simulations

T = 80;         % number of time periods (years)
r = 0.01;       % interest rate
beta = 1/(1+r); % discount factor
gamma = 1.5;    % coefficient of relative risk aversion
startA = 1;     % initial asset endowment

%% Grids
% Here we choose the dimension and select methods to construct grids

% grid for assets
numPtsA = 20;			 % number of points in the discretized asset grid
gridMethod = 'equalsteps';	 % method to construct the grid: equalsteps, logsteps, 3logsteps, 5logsteps or 10logsteps

%% Get asset grid
% Here we fill the assets' grid for each period using 'gridMethod'

[ MinAss, MaxAss ] = getMinAndMaxAss(startA);

Agrid = NaN(T+1, numPtsA);
for ixt = 1:1:T+1
    Agrid(ixt,:) = getGrid(MinAss(ixt), MaxAss(ixt), numPtsa, gridMethod);
end

%% Solve consumer's problem
% Get policy function and value function in all periods and for all grid
% points

[ policy_A1, policy_C, val] = solveValueFunction;

%% Simulate consumer's paths
% start from the initial level of assets and simulate optimal consumption and savings profiles
% over lifecyle

[ cpath, apath, vpath ] = simNoUncer(policyA1, val, startA);


%% ------------------------------------------------------------------------ 
% PLOTS 
% Plot paths of consumption and assets
plotNumber = 0;
plotApath(apath)
plotCpath(cpath)
%plotCZoomedOut(cpath)

% Plot value function
whichyear = 1;
plotNode1 = 1;
plotNodeLast = numPtsA;
plotV;


%% ------------------------------------------------------------------------ 
% Compare numerical and analytical solutions
% Get the analytical policy functions (in this case in the absence of uncertainty
% and borrowing constraints
[ policyA1_analytic, policyC_analytic ] = getPolicy_analytical;

% Get the ratio of numerical policy function to analytic policy functions
ratioOfPolicyC = policyC./policyC_analytic;
ratioOfPolicyA = policyA1./policyA1_analytic;

% Now plot value and policy functions
whichyear = 1;
plotNode1 = 3;
plotNodeLast = numPtsA;
plotNumericError;

%% ------------------------------------------------------------------------ 
% Stop the clock
toc;
































