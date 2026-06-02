function exampleHelperPlotHoverControlTrackingComparison(simOutBaseline,simOutTuned)
% exampleHelperPlotHoverControlTrackingComparison plot results for hover
% control analysis.

% Copyright 2023 The MathWorks, Inc.

%% Plot of Command vs Feedback
positionFeedbackDataBaseline = squeeze(simOutBaseline.PositionCmdFdbk.signals.values)';
positionFeedbackDataTuned = squeeze(simOutTuned.PositionCmdFdbk.signals.values)';

figure
subplot(3,1,1)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,4),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,4),'LineWidth',2)
hold off
grid
ylabel('X (m)')
legend('Baseline','Autotuned')
title('Position')

subplot(3,1,2)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,5),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,5),'LineWidth',2)
hold off
grid
ylabel('Y (m)')

subplot(3,1,3)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,6),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,6),'LineWidth',2)
hold off
grid
xlabel('Time (sec)')
ylabel('Z (m)')

%% Plot in X-Y-Z
figure
plot3(positionFeedbackDataBaseline(:,4),-positionFeedbackDataBaseline(:,5),-positionFeedbackDataBaseline(:,6),'LineWidth',2)
hold on
plot3(positionFeedbackDataTuned(:,4),-positionFeedbackDataTuned(:,5),-positionFeedbackDataTuned(:,6),'LineWidth',2)
hold off
grid
xlabel('North (m)')
ylabel('West (m)')
zlabel('Up (m)')
legend('Baseline', 'Autotuned')
title('Position')

%% Plot of Error
figure
subplot(4,1,1)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,1)-positionFeedbackDataBaseline(:,4),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,1)-positionFeedbackDataTuned(:,4),'LineWidth',2)
hold off
grid
ylabel('X (m)')
legend('Baseline','Autotuned')
title('Position Setpoint-Feedback Error')

subplot(4,1,2)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,2)-positionFeedbackDataBaseline(:,5),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,2)-positionFeedbackDataTuned(:,5),'LineWidth',2)
hold off
grid
ylabel('Y (m)')

subplot(4,1,3)
plot(simOutBaseline.PositionCmdFdbk.time,positionFeedbackDataBaseline(:,3)-positionFeedbackDataBaseline(:,6),'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,positionFeedbackDataTuned(:,3)-positionFeedbackDataTuned(:,6),'LineWidth',2)
hold off
grid
xlabel('Time (sec)')
ylabel('Z (m)')

ErrorNormBaseline = vecnorm(positionFeedbackDataBaseline(:,1:3) - positionFeedbackDataBaseline(:,4:6), 1, 2);
ErrorNormTuned = vecnorm(positionFeedbackDataTuned(:,1:3) - positionFeedbackDataTuned(:,4:6), 1, 2);

subplot(4,1,4)
plot(simOutBaseline.PositionCmdFdbk.time,ErrorNormBaseline,'LineWidth',2)
hold on
plot(simOutTuned.PositionCmdFdbk.time,ErrorNormTuned,'LineWidth',2)
grid
xlabel('Time (sec)')
ylabel('Norm (m)')

end