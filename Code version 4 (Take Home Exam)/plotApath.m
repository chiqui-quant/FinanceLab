function plotApath( apath, borrowingconstraints )

% ------------------------------------------------------------------------- 
% DESCRIPTION
% This function plots the simulated path of assets over the course of life

%% ------------------------------------------------------------------------ 
% Declare global we need this file have access to
global plotNumber numSims

%% ------------------------------------------------------------------------ 
% Draw and format graph
plotNumber = plotNumber + 1;
figure(plotNumber)
plot(apath,'LineWidth',2)
hold on
plot(borrowingconstraints, '--g','LineWidth', 2);
Legend=cell(numSims,1);
for i = 1:numSims
    Legend{i}=strcat('Individual ', num2str(i));
end
legend(Legend,'Location','best');
% legappend('Borrowing cons.'); % you can append the label for borrowing
% constraints if you install the package 'legappend'
xlabel('Age')
title('Simulated time path of assets')

% ------------------------------------------------------------------------- 
end

