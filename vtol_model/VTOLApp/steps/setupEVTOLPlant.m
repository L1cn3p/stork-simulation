%setupEVTOLPlant Setup EVTOL plant.

% Copyright 2025 The MathWorks, Inc.

% Load Model
mdl = 'EVTOLTiltrotor';
load_system(mdl);
% Define the aircraft modes of flight. 
Simulink.defineIntEnumType('flightState',...
{'Hover','Transition','FixedWing','BackTransition'},[0;1;2;3]);
% Set attitude to be 0.
iniRoll=0;
iniYaw=0;
initPitch=0;
% Set initial position to ground location in local coordinates (NED)
xGround=0;
yGround=0;
zGround=0;
% Set ground contact force model parameter
contact = struct('spring', 1.28931184836e5, ...
    'vd', 0.02, ...
    'slidingFriction', 0.8, ...
    'rollingFriction', 0.2,  ...
    'gLimit', 100);
% Define Bus interfaces for controller
exampleHelperDefineCtrlInterface;
% Define Plant bus interface.
exampleHelperDefineEVTOLDigitalTwinInterface
% Set VTOL Dynamics:Aerodynamics and Geometry Parameters
uavParam=exampleHelperSetVTOLDynamics;
% Flag to enable/disable visualization
Visualization = 1;
% Weight gain factor for sizing workflow
percWeightGain = 1; % default value 1
% Disable Wind
Wind=0;
% Disable Sensors
SensorType=0;
% Disable electric propulsion
ElectricPropulsion = 1;
% Setup tuning flag
TuningMode = 0;
Deployment = false;
% Initialize Control and Guidance gains for Tiltrotor
exampleHelperInitializeVTOLGains;
% Initialize initial velocity
vIni = 0;
disp("Initialized EVTOL model.")
% % Initialize hover configuration
setupHoverConfiguration

% Load motor controller gains
load('ElectricMotorPID.mat');
% Initialise battery parameters
BatteryParameter;
% Setup configuration set
configObj = getActiveConfigSet('VTOLAutopilotController');
set_param(configObj, 'SourceName', 'VTOLConfiguration');

% Additional tuning for better altitude performance with battery
controlParams.P_VZ=5;
controlParams.D_VZ=0;
controlParams.N_VZ=8.4215;
controlParams.P_Z= -1.8;

% controlParams.P_VZ=4;
% controlParams.D_VZ=0.5;
% controlParams.N_VZ=8.4215;
% controlParams.P_Z= -1.5;

% %% Y Rate Controller
% controlParams.P_VY= 0.2;
% controlParams.D_VY = 0.5518;
% controlParams.N_VY = 1.07046911218118;
% 
% %% Y Controller
% controlParams.P_Y=-0.8;%-1.03;