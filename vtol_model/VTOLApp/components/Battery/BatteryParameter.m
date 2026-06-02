%% Parameters for Lithium-Ion Battery Pack BMS example
% Battery parameters

% Copyright 2024 The MathWorks, Inc.
 

battery.samplingTime=1;   % Sampling time (s)

battery.T_vec=[278 293 313];       % Temperature vector T [K]
battery.AH=10;                     % [Ah] Cell capacity 
battery.AH_vec=[0.9*battery.AH battery.AH 0.9*battery.AH]; % Cell capacity vector AH(T) [Ahr]
battery.SOC_vec=[0, .1, .25, .5, .75, .9, 1]; % Cell state of charge vector SOC [-]
battery.initialPackSOC=0.75;	     % Pack intial SOC (-)
vehicleThermal.ambient=25+273.15;          %[K] Ambient temperature in K


%% Cell Thermal
battery.MdotCp=100;        % Cell thermal mass (mass times specific heat [J/K])
battery.coolantRes=1.2; % Cell level coolant thermal path resistance, K/W

%% Module Electrical
battery.Ns=6;    % Number of series connected strings
battery.Np=1;      % Number of parallel cells per string


%% Cell Thermal
battery.MdotCp=100;        % Cell thermal mass (mass times specific heat [J/K])
battery.CoolantRes=1.2; % Cell level coolant thermal path resistance, K/W
battery.CoolantSwitchOnTp=320; % [K] Temperature to switch on coolant flow
battery.CoolantSwitchOffTp=303; % [K] temperature to switch of coolant flow
battery.ThermalMass=100*battery.Np*battery.Ns; % [J/K] 


%% Battery CC-CV charger parameters
battery.ChargeMaxVolt = 4.2; % Maximum voltage for charger V
battery.ChargeKp = 1; % Charger controller proportional gain
battery.ChargerKi = 1; % Charger controller integral gain
battery.ChargerKaw = 1; % Charger controller anti-windup gain

%% Battery Fault Parameters

% Voltage Fault parameters
battery.MinVoltLmt=3;    % Min Cell Voltage limit (V)
battery.MaxVoltLmt=4.2;  % Max Cell Voltage limit (V)
battery.VoltOffset=0.2;     % Voltage offset for immediate fault (V)

% Current fault parameters
battery.MaxChrgCurLim=100;   % Max Charging Current (A)
battery.MaxDchrgCurLim=120;  % Max Discharging Current (A)
battery.ChargerCC_A=50;      % Charger constant current value (A)
battery.ChargerCV_V=62;      % Constant voltage charger value (V)
battery.CurrOffset=20;       % Current offset for immediate fault (A)

% Thermal Fault parameters
battery.MinThLmt=263.15;    % [K] Min Cell temp for fault in K - 10 deg Celcius
battery.MaxThLmt=333.15;    % [K] Max Cell temp for fault in K - 60 deg Celcius

