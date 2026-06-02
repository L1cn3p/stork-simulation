function simAttackAnglePlotter(simData,capacityRange)
%   Plots angle of attack of UAV in fixed wing mode for various battery
%   sizes
figure
hold on
for i= 1:size(simData,2)
    plotName = [num2str(capacityRange(i)) 'Wh'];
    plot(simData(1,i).time,simData(1,i).Data*57.2958,LineWidth=1,DisplayName= plotName);
end
hold off
end