%cleanupVTOL clean up VTOL parameters.

% Copyright 2023 The MathWorks, Inc.

clear AAC FSState controlParams FWControlParams FixedWingCommandBus 
clear FixedWingCtrlBus ForwardVelocityCutoff HoverMission R_LOOKAHEAD R_WAYPOINTTRANSITION
clear ReferenceFilterDen ReferenceFilterNum RotorCntrlBus SensorAAFiltDen SensorAAFiltNum
clear SensorType TestMode TuningMode Visualization controlMode controlParams dDataSectObj
clear guidanceType iniRoll iniYaw initPitch mdl minPWM myDictionaryObj simTimeParam tiltIni tilt_max uavParam vIni

myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
discardChanges(myDictionaryObj);

close(myDictionaryObj)
proj = matlab.project.rootProject;
projFiles = findFiles(proj);
modelFiles = projFiles(endsWith(projFiles,".slx"));
for idx = 1:numel(modelFiles)
    close_system(modelFiles(idx), 0);
end

clear idx modelFiles myDictionaryObj proj projFiles
