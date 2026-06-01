%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stork_chap2.m
%     - Chapter 2: State/Pose model for Flightory Stork VTOL
%     - Based on Beard & McLain, PUP, 2012, Chapter 2
%     - Adapted from mavsim_chap2.m (byu-magicc/mavsim_public)
%     - Update history:
%         June 2026 - adapted for Stork VTOL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load paths
[stork_root, ~, ~] = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(stork_root, 'utils'));
mavsim_root = fullfile(stork_root, '..', 'mavsim_public', 'mavsim_matlab');
addpath(fullfile(mavsim_root, 'tools'));
addpath(fullfile(mavsim_root, 'parameters'));
addpath(fullfile(mavsim_root, 'message_types'));
addpath(fullfile(mavsim_root, 'chap2'));
addpath(genpath(fullfile(stork_root, '..', 'mavsim_public', 'mavsim_simulink')));
addpath(fullfile(stork_root, 'params'));
% load simulation and aircraft parameters
run(fullfile(mavsim_root, 'parameters', 'simulation_parameters'));
stork_parameters;

% initialize messages
state = msg_state();

% initialize the mav viewer
mav_view = spacecraft_viewer();

% initialize the simulation time
sim_time = SIM.start_time;

% main simulation loop
disp('Type CTRL-C to exit');
while sim_time < SIM.end_time

    %-------vary states to check viewer-------------
    if sim_time < SIM.end_time/6
        state.pn = state.pn + SIM.ts_simulation;
    elseif sim_time < 2*SIM.end_time/6
        state.pe = state.pe + SIM.ts_simulation;
    elseif sim_time < 3*SIM.end_time/6
        state.h = state.h + SIM.ts_simulation;
    elseif sim_time < 4*SIM.end_time/6
        state.phi = state.phi + 0.1*SIM.ts_simulation;
    elseif sim_time < 5*SIM.end_time/6
        state.theta = state.theta + 0.1*SIM.ts_simulation;
    else
        state.psi = state.psi + 0.1*SIM.ts_simulation;
    end

    %-------update viewer-------------
    mav_view.update(state);

    %-------increment time-------------
    sim_time = sim_time + SIM.ts_simulation;

end