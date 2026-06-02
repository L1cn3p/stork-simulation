%exampleHelperHoverModeRangeComputation Compute battery range for hover
%mode

% Copyright 2025 The MathWorks, Inc.

for i = 1:size(capacityRange,2)
    % Battery weight for given capacity
    batteryWeight = capacityRange(i)/battery.GravDensity;        
    % Increase in total mass of the aircraft due to battery 
    percWeightGain =  (baseMass + batteryWeight)/baseMass;
    % Calculate new w_trim 
    exampleHelperComputeTrim; 
    % Simulate model
    simData = sim(mdl);
    % Calculate the hover range by dividing the battery capacity by the energy consumption rate    
    hover.range = [hover.range capacityRange(i)/simData.EnergyMileage.Data(end)];
    hover.mileage = [hover.mileage simData.EnergyMileage.Data(end)];
end