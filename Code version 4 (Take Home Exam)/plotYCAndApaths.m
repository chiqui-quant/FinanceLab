function plotYCAndApaths( ypath, cpath, apath )

% ------------------------------------------------------------------------- 
% DESCRIPTION
% This function plots the simulated paths of assets, consumption and income
% over the course of life. Does so for each simulated individual 
% separately.

%% ------------------------------------------------------------------------ 
% Declare global we need this file have access to
global plotNumber numSims

for i = 1:numSims
    plotNumber = plotNumber + 1;
    figure(plotNumber)
    plot(ypath(:,i),'r','LineWidth',2)
    hold on;
    plot(cpath(:,i),'g','LineWidth',2)
    hold on;
    plot(apath(:,i),'b','LineWidth',2)
    hold on;
    legend('Income','Consumption','Assets','Location','best');
    xlabel('Age');
    title(['Time path of income, consumption and assets - individual ', num2str(i)])
end

% ------------------------------------------------------------------------- 
end
