% Calculate new w_trim
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
cq = 8/(pi^3)*0.007048;
% increase thrust coefficient for evtol
% uavParam.motor.RPMMAX = 20000;
dct = 2.0;
ct = 4/(pi^3)*0.1142*dct;
rho = 1.225;
% radius of rotor in (m)
r = 0.1526;
m = uavParam.geom.mass*percWeightGain; % mass in kg
g = 9.81;
thrust_req = m*g/4;
% trim rotation in radians per second
w = sqrt(thrust_req/(ct*rho*pi*r^4));
% trim rotation in revolutions per second
wtrim = w/(2*pi);
%simTimeParam = getEntry(dDataSectObj,'simTime');
setValue(getEntry(dDataSectObj,'w_trim'),wtrim);