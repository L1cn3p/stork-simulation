%exampleHelperFixedWingRangeComputation Compute battery range for urban
%mission

% Copyright 2025 The MathWorks, Inc.

for i = 1:size(capacityRange,2)
    % Battery weight for given capacity
    batteryWeight = capacityRange(i)/battery.GravDensity;
    % Increase in total mass of the aircraft due to battery     
    percWeightGain =  (baseMass + batteryWeight)/baseMass;    
    % Simulate model    
    simData = sim(mdl);
    % Angle of attack value
    angleOfAttack = [angleOfAttack simData.Alpha];
    % Calculate the Fixed flight range by dividing the battery capacity by the energy consumption rate    
    fixedwing.range = [fixedwing.range capacityRange(i)/simData.EnergyMileage.Data(end)];
    fixedwing.mileage = [fixedwing.mileage simData.EnergyMileage.Data(end)];
end