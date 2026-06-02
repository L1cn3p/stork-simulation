function exampleHelperPlotHoverControlTrackingResults(simOut)
% exampleHelperPlotHoverControlTrackingResults plot results for hover
% analysis.

% Copyright 2023 The MathWorks, Inc.

%% 2D Plot of Command vs Feedback
positionFeedbackData = squeeze(simOut.PositionCmdFdbk.signals.values);

figure
subplot(3,1,1)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(1,:),simOut.PositionCmdFdbk.time,positionFeedbackData(4,:),'LineWidth',2)
grid
ylabel('X (m)')
legend('Setpoint','Feedback')
title('Position')

subplot(3,1,2)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(2,:),simOut.PositionCmdFdbk.time,positionFeedbackData(5,:),'LineWidth',2)
grid
ylabel('Y (m)')

subplot(3,1,3)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(3,:),simOut.PositionCmdFdbk.time,positionFeedbackData(6,:),'LineWidth',2)
grid
xlabel('Time (sec)')
ylabel('Z (m)')

%% 3D Plot of Command vs Feedback
figure
plot3(positionFeedbackData(1,:),-positionFeedbackData(2,:),-positionFeedbackData(3,:),'LineWidth',2)
hold on
plot3(positionFeedbackData(4,:),-positionFeedbackData(5,:),-positionFeedbackData(6,:),'LineWidth',2)
hold off
grid
xlabel('North (m)')
ylabel('West (m)')
zlabel('Up (m)')
legend('Setpoint', 'Feedback')
title('Position')

%% Plot of Error
figure
subplot(4,1,1)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(1,:)-positionFeedbackData(4,:),'LineWidth',2)
grid
ylabel('X (m)')
title('Position Setpoint-Feedback Error')

subplot(4,1,2)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(2,:)-positionFeedbackData(5,:),'LineWidth',2)
grid
ylabel('Y m)')

subplot(4,1,3)
plot(simOut.PositionCmdFdbk.time,positionFeedbackData(3,:)-positionFeedbackData(6,:),'LineWidth',2)
grid
xlabel('Time (sec)')
ylabel('Z (m)')

error = vecnorm(positionFeedbackData(1:3,:) - positionFeedbackData(4:6,:), 2, 1);
subplot(4,1,4)
plot(simOut.PositionCmdFdbk.time,error,'LineWidth',2)
grid
xlabel('Time (sec)')
ylabel('Norm (m)')
end