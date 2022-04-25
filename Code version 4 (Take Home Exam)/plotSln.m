% ------------------------------------------------------------------------- 
% DESCRIPTION
% This script plots the policy and value functions against assets for a 
% given time period and value of income

%% ------------------------------------------------------------------------ 
% Declare global we need this file have access to
global plotNumber                                   % for graphing

%% ------------------------------------------------------------------------ 
% PLOT POLICY FUNCTION: CONSUMPTION
% numerical and analytical solutions: consumption as a function of assets 
% in period 'whichyear'

plotNumber = plotNumber + 1;
figure(plotNumber);
plot(Agrid(whichyear,plotNode1:plotNodeLast), policyC(whichyear,plotNode1:plotNodeLast,numPtsY), 'g', 'LineWidth', 2)
hold on;
plot(Agrid(whichyear,plotNode1:plotNodeLast), policyC(whichyear,plotNode1:plotNodeLast,numPtsY-1), 'b', 'LineWidth', 2)
hold on;
plot(Agrid(whichyear,plotNode1:plotNodeLast), policyC(whichyear,plotNode1:plotNodeLast,numPtsY-2), 'm', 'LineWidth', 2)
hold on;
plot(Agrid(whichyear,plotNode1:plotNodeLast), policyC(whichyear,plotNode1:plotNodeLast,1), 'r', 'LineWidth', 2)
hold on;
xlabel('Asset');
ylabel('Policy function (consumption function)');
legend('Higest income','Middle-higher income','Middle-lower income', 'Lowest income', 'Location', 'southeast');
title('Policy function (consumption function)')
 
%% ------------------------------------------------------------------------ 
% PLOT VALUE FUNCTION
% plotNumber = plotNumber + 1;
% figure(plotNumber);
% plot(Agrid(whichyear,plotNode1:plotNodeLast), val(whichyear,plotNode1:plotNodeLast,numPtsY), 'g', 'LineWidth', 2)
% hold on;
% plot(Agrid(whichyear,plotNode1:plotNodeLast), val(whichyear,plotNode1:plotNodeLast,numPtsY-1), 'b', 'LineWidth', 2)
% hold on;
% plot(Agrid(whichyear,plotNode1:plotNodeLast), val(whichyear,plotNode1:plotNodeLast,numPtsY-2), 'm', 'LineWidth', 2)
% hold on;
% plot(Agrid(whichyear,plotNode1:plotNodeLast), val(whichyear,plotNode1:plotNodeLast,numPtsY-3), 'r', 'LineWidth', 2)
% hold on;
% xlabel('Asset');
% ylabel('Value');
% legend('Value for highest inc.','Value for middle-higher inc.','Vlue for middle-lower inc.','Value for lowest inc.', 'Location','southeast');
% title('Value function')

% ------------------------------------------------------------------------- 

