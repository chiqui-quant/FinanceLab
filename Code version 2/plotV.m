% Here we plot the numerical approximation of the value function for a period
% 'whichyear', between the grid points of plotNode1 and plotNodeLast

global plotNumber

plotNumber = plotNumber + 1;
figure(plotNumber);
plot( Agrid(whichyear,plotNode1:plotNodeLast), ...
      val(whichyear,plotNode1:plotNodeLast), 'r', 'LineWidth',2)
xlabel('Assets');
ylabel('Value');
legend('Value function');
title('Value function')

