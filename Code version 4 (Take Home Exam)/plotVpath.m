function plotVpath( vpath )

% ------------------------------------------------------------------------- 
% DESCRIPTION
% This function plots the simulated value function over the course of life

%% ------------------------------------------------------------------------ 
% Declare global we need this file have access to
global plotNumber 

%% ------------------------------------------------------------------------ 
% Draw and format graph
plotNumber = plotNumber + 1;
figure(plotNumber)
mean_value = mean(vpath,2); % mean(vpath,2) averages across time periods for
% all individuals (recall that vpath is 40x10)
plot(mean_value,'-.k','LineWidth',4)
legend('Mean', 'Location', 'best')
hold on
plot(vpath,'LineWidth',0.5);
xlabel('Age');
ylabel('Value');
title('Time path of value for each individual')

% ------------------------------------------------------------------------- 
end
