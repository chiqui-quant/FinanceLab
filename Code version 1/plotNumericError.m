% This script displays both the policy and value functions
% obtained nuerically and analytically. 

global plotNumber

% -------------------------------------------------------------------------
% Plot Savings (numerical and analytical solutions)
% savings as a function of assets in period 'whichyear'

plotNumber = plotNumber + 1;
figure(plotNumber);
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          policyA1(whichyear,plotNode1:plotNodeLast), 'r', 'LineWidth', 2)
    hold on;
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          policyA1_analytic(whichyear,plotNode1:plotNodeLast), 'g', 'LineWidth', 2)
    hold on;
    xlabel('Assets at t');
    ylabel('Policy function: assets at t+1');
    legend('Numerical', 'Analytical');
    title('Comparing numerical and analytical savings functions')   

% -------------------------------------------------------------------------
% Plot Consumption (numerical and analytical solutions)
% consumption as a function of assets in period 'whichyear'

plotNumber = plotNumber + 1;
figure(plotNumber);
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          policyC(whichyear,plotNode1:plotNodeLast), 'r', 'LineWidth', 2)
    hold on;
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          policyC_analytic(whichyear,plotNode1:plotNodeLast), 'g', 'LineWidth', 2)
    hold on;
    xlabel('Assets');
    ylabel('Policy function: consumption)');
    legend('Numerical', 'Analytical');
    title('Comparing numerical and analytical consumption functions')   

% -------------------------------------------------------------------------
% Plot relative numerical error
% Note: this is the difference between the analytical (exact solution) and the
% numerical one

plotNumber = plotNumber + 1;
figure(plotNumber);
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          ratioOfPolicyA(whichyear,plotNode1:plotNodeLast), 'r', 'LineWidth', 2)
    hold on;
    plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
          ratioOfPolicyC(whichyear,plotNode1:plotNodeLast), 'g', 'LineWidth', 2)
    hold on;
    xlabel('Assets at t');
    ylabel('Ratio');
    legend('Savings', 'Consumption');
    title('Ratio of numeric and analytic solutions: consumption and savings')   


