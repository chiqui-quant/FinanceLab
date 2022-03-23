% This function plots the simulated path of consumption over the
% entire set of periods using a fixed range of variation

global plotNumber T

lowerboundforyaxis = 0; % min(cpath)*0.9
upperboundforyaxis = 0.12; % max(cpath)*1.1

plotNumber = plotNumber + 1;
figure(plotNumber)
plot(cpath,'LineWidth',2)
axis([1 T lowerboundforyaxis upperboundforyaxis])
xlabel('Age')
ylabel('Consumption')
title('Time path of consumption')

end
