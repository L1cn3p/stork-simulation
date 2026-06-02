% Load Model
mdl = 'VTOLTiltrotor';
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

% Set VTOL Dynamics:Aerodynamics and Geometry Parameters
uavParam=exampleHelperSetVTOLDynamics;
% Flag to enable/disable visualization
Visualization = 1;
% Disable electric propulsion
ElectricPropulsion = 0;
% Initialize percent weight gain
percWeightGain = 1; 
% Disable Wind
Wind=0;
% Disable Sensors
SensorType=0;
% Setup tuning flag
TuningMode = 0;
Deployment = false;
% Initialize Control and Guidance gains for Tiltrotor
exampleHelperInitializeVTOLGains;
% Initialize initial velocity
vIni = 0;
disp("Initialized VTOL model.")
% Initialize hover configuration
setupHoverConfiguration
setupHoverGuidanceMission
% Setup configuration set
configObj = getActiveConfigSet('VTOLAutopilotController');
set_param(configObj, 'SourceName', 'VTOLConfiguration');

% Calculate w_trim
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');

% thrust and torque coefficient
cq = 8/(pi^3)*0.007048;
ct = 4/(pi^3)*0.1142;

% air density
rho = 1.225;
% radius of rotor in (m)
r = 0.1526;
% mass of VTOL UAV
m = 6.031;
g = uavParam.aero.g;
thrust_req = m*g/4;
% trim rotation in radians per second
w = sqrt(thrust_req/(ct*rho*pi*r^4));
% trim rotation in revolutions per second
wtrim = w/(2*pi);
% set w_trim value in data dictionary
setValue(getEntry(dDataSectObj,'w_trim'),wtrim);
