% This function plots the simulated path of assets over the entire set of periods
function plotApath(apath)

global plotNumber

% Draw and format graph
plotNumber = plotNumber +1;
figure(plotNumber)
plot(apath,'LineWidth',2)
xlabel('Age')
ylabel('Assets')
hold on
title('Time path of assets')

end

