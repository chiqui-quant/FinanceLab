function plotYAndCpaths( ypath, cpath )

% ------------------------------------------------------------------------- 
% DESCRIPTION
% This function plots the simulated paths of consumption and income over
% the course of life. Does so for each simulated individual separately.

%% ------------------------------------------------------------------------ 
% Declare global we need this file have access to
global plotNumber numSims

%% ------------------------------------------------------------------------ 
% Draw and format graph

for i = 1:numSims
    plotNumber = plotNumber + 1;
    figure(plotNumber)
    plot(ypath(:,i),'r','LineWidth',2)
    hold on;
    plot(cpath(:,i),'g','LineWidth',2)
    hold on;
    legend('Income','Consumption','Location','best');
    xlabel('Age');
    title(['Time path of income and consumption - individual ', num2str(i)])
end

% ------------------------------------------------------------------------- 
end
