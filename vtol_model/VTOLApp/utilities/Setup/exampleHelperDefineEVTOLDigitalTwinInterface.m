function exampleHelperDefineEVTOLDigitalTwinInterface()
%exampleHelperDefineDigitalTwinInterface define digital twin interface for
%VTOL.

% Copyright 2023 The MathWorks, Inc.
%% Design bus - Fixed Wing Control
clear elems
elems(1) = Simulink.BusElement;
elems(1).Name = 'dA';
elems(2) = Simulink.BusElement;
elems(2).Name = 'dE';
elems(3) = Simulink.BusElement;
elems(3).Name = 'dR';
elems(4) = Simulink.BusElement;
elems(4).Name = 'dT';
FixedWingCtrlBus = Simulink.Bus;
FixedWingCtrlBus.Elements = elems;
%% Design bus - Rotor Control
clear elems
elems(1) = Simulink.BusElement;
elems(1).Name = 'w1';
elems(2) = Simulink.BusElement;
elems(2).Name = 'w2';
elems(3) = Simulink.BusElement;
elems(3).Name = 'w3';
elems(4) = Simulink.BusElement;
elems(4).Name = 'w4';
elems(5) = Simulink.BusElement;
elems(5).Name = 'Tilt1';
elems(6) = Simulink.BusElement;
elems(6).Name = 'Tilt2';
elems(7) = Simulink.BusElement;
elems(7).Name = 'T1';
elems(8) = Simulink.BusElement;
elems(8).Name = 'T2';
elems(9) = Simulink.BusElement;
elems(9).Name = 'T3';
elems(10) = Simulink.BusElement;
elems(10).Name = 'T4';


RotorCntrlBus = Simulink.Bus;
RotorCntrlBus.Elements = elems;
%% Assign into base workspace
assignin('base',"FixedWingCtrlBus",FixedWingCtrlBus);
assignin('base',"RotorCtrlBus",RotorCntrlBus);
end