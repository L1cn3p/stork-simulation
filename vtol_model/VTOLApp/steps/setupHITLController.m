%% Setup Controller
%Load Control Gains for HITL

%   Copyright 2024-2026 The MathWorks, Inc.

load(fullfile('data','tunedHITLFixedWingGains.mat'));
load(fullfile('data','tunedHITLHoverGains.mat'));
%% Load Bus Interfaces
%Control Bus interface for the guidance module
exampleHelperDefineCtrlInterface;

%% Configure variant
% Tuning Mode is off.
TuningMode=0;
Deployment = true;
% Set Test Bench to execute complex guidance mission
% Variant switch for 'VTOLAutopilotController/Guidance Test Bench/ControlType'
TestMode=1;
%% Configure model for deployment
% Setup configuration set
load_system("VTOLAutopilotController");
configObj = getActiveConfigSet('VTOLAutopilotController');
set_param(configObj, 'SourceName', 'DeploymentConfiguration');
%% Filters
ForwardVelocityCutoff = 3;
SensorAAFiltNum = 4.386e+06;
SensorAAFiltDen = [1 2.96e+03 4.386e+06];
ReferenceFilterNum = 0.04877;
ReferenceFilterDen = [1 -0.9512];
%% Set Home Location for Landing Detection
xGround=0;
yGround=0;
zGround=0;
