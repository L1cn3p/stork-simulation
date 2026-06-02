%exampleHelperUrbanMissionRangeComputation Compute battery range for urban
%mission

% Copyright 2025 The MathWorks, Inc.

for i = 1:size(capacityRange,2)
    % Battery weight for given capacity
    batteryWeight = capacityRange(i)/battery.GravDensity; 
    % Increase in total mass of the aircraft due to battery 
    percWeightGain =  (baseMass + batteryWeight)/baseMass;
    % Compute trim value
    exampleHelperComputeTrim;
    % Simulate model
    simData = sim(mdl);    
    % Calculate the hover range by dividing the battery capacity by the energy consumption rate    
    mission.range = [mission.range capacityRange(i)/simData.EnergyMileage.Data(end)];
    mission.mileage = [mission.mileage simData.EnergyMileage.Data(end)];
end