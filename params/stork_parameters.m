% initialize the mav viewer
[stork_root, ~, ~] = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(stork_root, 'utils'));
addpath(fullfile(stork_root, '..', 'mavsim_public', 'mavsim_matlab', 'tools'));

MAV.gravity = 9.81;

%physical parameters of airframe
% Source: Flightory Stork VTOL User Manual V.2 (flightory.com)
% ESTIMATED values marked — see assumptions table

MAV.mass = 2.5;      % kg — ESTIMATED (manual states AUW 1400-3100g, 2.5kg typical VTOL build on 4S)
MAV.Jx   = 0.0822;   % kg m^2 — ESTIMATED (wing modelled as thin rectangular plate)
MAV.Jy   = 0.0785;   % kg m^2 — ESTIMATED (fuselage modelled as slender rod)
MAV.Jz   = 0.1365;   % kg m^2 — ESTIMATED (planform area approximation)
MAV.Jxz  = 0.0050;   % kg m^2 — ESTIMATED (assumed near-zero, symmetric airframe)

% initial conditions
MAV.pn0    = 0;     % initial North position
MAV.pe0    = 0;     % initial East position
MAV.pd0    = -100;  % initial Down position (negative altitude, NED convention)
MAV.u0     = 0;     % initial velocity along body x-axis (starting from hover)
MAV.v0     = 0;     % initial velocity along body y-axis
MAV.w0     = 0;     % initial velocity along body z-axis
MAV.phi0   = 0;     % initial roll angle
MAV.theta0 = 0;     % initial pitch angle
MAV.psi0   = 0;     % initial yaw angle
e = Euler2Quaternion(MAV.phi0, MAV.theta0, MAV.psi0);
MAV.e0     = e(1);  % initial quaternion
MAV.e1     = e(2);
MAV.e2     = e(3);
MAV.e3     = e(4);
MAV.p0     = 0;     % initial body frame roll rate
MAV.q0     = 0;     % initial body frame pitch rate
MAV.r0     = 0;     % initial body frame yaw rate

% Gamma parameters from uavbook page 36
% Derived automatically from inertia values — do not edit manually
MAV.Gamma  = MAV.Jx*MAV.Jz-MAV.Jxz^2;
MAV.Gamma1 = (MAV.Jxz*(MAV.Jx-MAV.Jy+MAV.Jz))/MAV.Gamma;
MAV.Gamma2 = (MAV.Jz*(MAV.Jz-MAV.Jy)+MAV.Jxz*MAV.Jxz)/MAV.Gamma;
MAV.Gamma3 = MAV.Jz/MAV.Gamma;
MAV.Gamma4 = MAV.Jxz/MAV.Gamma;
MAV.Gamma5 = (MAV.Jz-MAV.Jx)/MAV.Jy;
MAV.Gamma6 = MAV.Jxz/MAV.Jy;
MAV.Gamma7 = (MAV.Jx*(MAV.Jx-MAV.Jy)+MAV.Jxz*MAV.Jxz)/MAV.Gamma;
MAV.Gamma8 = MAV.Jx/MAV.Gamma;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aerodynamic coefficients

% Geometric parameters — source: Flightory Stork manual (measured design values)
MAV.S_wing        = 0.31;    % m^2   — wing area (manual: 31 dm^2)
MAV.b             = 1.620;   % m     — wingspan (manual: 1620mm)
MAV.c             = 0.195;   % m     — mean aerodynamic chord (manual: 195mm)
MAV.AR            = MAV.b^2/MAV.S_wing; % aspect ratio — auto-calculated (manual: 8.3)
MAV.e             = 0.85;    % —     — ESTIMATED Oswald efficiency (rectangular wing, AR 8.3)
MAV.S_prop        = 0.2027;  % m^2   — ESTIMATED pusher prop disk area (pending step 5)
MAV.rho           = 1.225;   % kg/m^3 — ISA standard sea level air density
MAV.k_motor       = 80;      % —     — ESTIMATED motor constant (placeholder, update in step 5)
MAV.k_T_P         = 0;
MAV.k_Omega       = 0;

% Lift coefficients
% Source: S3021 polar data Re200k + Stork CFD charts (manual p.7)
MAV.C_L_0         = 0.02;    % — from Stork CFD chart (CL vs CD), CL at alpha~0 (approx +/-0.01)
MAV.C_L_alpha     = 5.55;    % per radian — derived from S3021 polar Re200k, alpha 0-6 deg
MAV.C_L_q         = 7.95;    % ESTIMATED — retained from Aerosonde (no Stork-specific data)
MAV.C_L_delta_e   = 0.13;    % ESTIMATED — retained from Aerosonde, V-tail data unavailable

% Drag coefficients
% Source: S3021 polar data Re200k
MAV.C_D_0         = 0.0139;  % — from S3021 polar Re200k at alpha=-3 deg (CL~0)
MAV.C_D_alpha     = 0.0334;  % per radian — derived from S3021 polar Re200k, alpha 0-6 deg
MAV.C_D_p         = 0.0;     % — assumed negligible, standard simplification
MAV.C_D_q         = 0.0;     % — assumed negligible, standard simplification
MAV.C_D_delta_e   = 0.0135;  % ESTIMATED — retained from Aerosonde, V-tail data unavailable

% Pitching moment coefficients
% Source: Stork CFD charts (manual p.7)
MAV.C_m_0         = 0.0;     % — from Stork CFD chart (Cm vs Alpha), Cm~0 at alpha=0
MAV.C_m_alpha     = -1.79;   % per radian — read from Stork CFD chart (Cm vs Alpha), slope -0.0312/deg
MAV.C_m_q         = -38.21;  % ESTIMATED — retained from Aerosonde (no Stork-specific data)
MAV.C_m_delta_e   = -0.99;   % ESTIMATED — retained from Aerosonde, V-tail data unavailable

% Lateral/directional coefficients
% ESTIMATED — all retained from Aerosonde (no Stork-specific data available)
% Note: V-tail coefficients would require AVL analysis or dedicated CFD to derive properly
MAV.C_Y_0         = 0.0;
MAV.C_Y_beta      = -0.83;
MAV.C_Y_p         = 0.0;
MAV.C_Y_r         = 0.0;
MAV.C_Y_delta_a   = 0.075;
MAV.C_Y_delta_r   = 0.19;
MAV.C_ell_0       = 0.0;
MAV.C_ell_beta    = -0.13;
MAV.C_ell_p       = -0.51;
MAV.C_ell_r       = 0.045;
MAV.C_ell_delta_a = 0.17;
MAV.C_ell_delta_r = 0.0024;
MAV.C_n_0         = 0.0;
MAV.C_n_beta      = 0.073;
MAV.C_n_p         = -0.069;
MAV.C_n_r         = -0.095;
MAV.C_n_delta_a   = -0.011;
MAV.C_n_delta_r   = -0.069;

% Stall model parameters
MAV.C_prop        = 1.0;
MAV.M             = 50;
MAV.epsilon       = 0.16;
MAV.alpha0        = 0.47;    % ESTIMATED — stall angle approx 27 deg from polar data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters for propulsion thrust and torque models
% Motor: BrotherHobby Avenger 2812 V5 910KV (pusher only)
% Source: brotherhobbystore.com + Flightory Stork manual p.13-14

% Prop parameters
% 4S config uses 10x6 two-blade propeller per Stork manual
MAV.D_prop = 10*(0.0254);    % m — 10 inch pusher prop (4S config, Stork manual p.14)

% Motor parameters
MAV.K_V     = 910;                        % RPM/V — from BrotherHobby official spec
MAV.KQ      = (1/MAV.K_V)*60/(2*pi);     % N-m/A, V-s/rad — derived from K_V
MAV.R_motor = 0.10;                       % ohms — ESTIMATED (typical for 2812-class motor, not published)
MAV.i0      = 1.5;                        % A — ESTIMATED no-load current (typical for this motor class)

% Inputs
% 4S configuration — lighter, efficient cruise, consistent with 2.5kg AUW estimate
MAV.ncells = 4;                           % cells — 4S LiPo (Stork manual recommends 4S or 6S)
MAV.V_max  = 3.7*MAV.ncells;             % V — nominal max voltage (14.8V on 4S)

% Prop disk area (used in thrust model)
MAV.S_prop = pi*(MAV.D_prop/2)^2;        % m^2 — auto-calculated from D_prop (0.0507 m^2)

% Coefficients from prop data fit
% ESTIMATED — Aerosonde placeholder values retained
% Note: should be replaced with values fitted to 10x6 two-blade prop data
% (e.g. from UIUC propeller database: https://m-selig.ae.illinois.edu/props/propDB.html)
MAV.C_Q2 = -0.01664;
MAV.C_Q1 =  0.004970;
MAV.C_Q0 =  0.005230;
MAV.C_T2 = -0.1079;
MAV.C_T1 = -0.06044;
MAV.C_T0 =  0.09357;