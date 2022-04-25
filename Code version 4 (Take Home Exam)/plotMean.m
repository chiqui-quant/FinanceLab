% ------------------------------------------------------------------------- 
% DESCRIPTION
% This script plots (on the same graph) the average simulated consumption
% and assets taken across all individuals.
%% ------------------------------------------------------------------------ 
global plotNumber 

%% ------------------------------------------------------------------------ 
% Draw and format graph
plotNumber = plotNumber + 1;
figure(plotNumber)
avg_assets = mean(apath,2); % mean(apath,2) averages across time periods for
% all individuals 
plot(avg_assets,'b','LineWidth',2)
hold on
avg_consum = mean(cpath,2); % average consumption across time for all individuals
plot(avg_consum,'r','LineWidth',2)
legend('Avg. assets','Avg. consumption',Location='best');
xlabel('Age');
ylabel('Consumption');
title('Average consumption and assets')