% Copyright 2025 The MathWorks, Inc.

% Setup plant
setupEVTOLPlant;

% Setup Hover configuration.
FSState=flightState.Hover;

% Set Test Bench to execute complex guidance mission
TestMode=1;

% Set guidance type to execute fixed wing mission.
guidanceType=3;

% Enable Visualization
Visualization = 1;

%Disable Sensors
SensorType=0;

%Load in Transition Misison
exampleHelperEVTOLTransitionMissionData;
% exampleHelperTransitionMissionData;
% Load controller gains for hover mode
% load tunedHoverGains_BW50;
% exampleHelperInitializeVTOLGains;
% % Load controller gains for fixed-wing mode
load tunedFixedWingGains_BW10.mat

disp("Enabled urban mission.")

%Open data dictionary
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
%Set Time for Simulation
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
simTimeParam = getEntry(dDataSectObj,'simTime');
setValue(simTimeParam,200)

% Additional paramter tuning for transition modes
% Initial value was 15 deg.
tiltRateParam = getEntry(dDataSectObj,'TiltScheduleRate');
setValue(tiltRateParam,12*pi/180)

% Initial value was 60 deg.
criticalAngleParam = getEntry(dDataSectObj,'CriticalTiltAngle');
setValue(criticalAngleParam,80*pi/180)

