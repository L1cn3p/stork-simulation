# State/Pose Model

**Chapter:** Beard & McLain Ch. 2  
**Implementation:** `simulation/stork_pose_viewer.m`  
**Status:** Complete ✅

---

## Purpose

The state/pose model defines the complete mathematical description of the Stork VTOL's position and orientation in space at any instant in time. It establishes the 13-element rigid-body state vector that feeds every subsequent model in the simulation pipeline — kinematic, dynamic, and control. Without a well-defined state vector and consistent frame convention, none of the downstream models can be correctly formulated.

---

## Main Assumptions

- The Stork is modelled as a **rigid body** — structural flexibility and vibration are ignored
- The Earth is treated as **flat and non-rotating** — valid for short-range missions at low altitude
- The **NED (North-East-Down) coordinate frame** is used as the inertial reference frame
- Attitude is represented using **unit quaternions** rather than Euler angles to avoid gimbal lock singularities
- The state vector is **airframe-agnostic** — the same 13-state formulation applies to any rigid-body UAV regardless of configuration (fixed-wing, quadrotor, VTOL)

---

## State Vector

The 13-element state vector is defined as:

```
x = [pn, pe, pd, u, v, w, e0, e1, e2, e3, p, q, r]
```

| Index | Symbol | Description | Units | Frame |
|-------|--------|-------------|-------|-------|
| 1 | pn | North position | m | Inertial (NED) |
| 2 | pe | East position | m | Inertial (NED) |
| 3 | pd | Down position (negative altitude) | m | Inertial (NED) |
| 4 | u | Velocity along body x-axis (forward) | m/s | Body |
| 5 | v | Velocity along body y-axis (right) | m/s | Body |
| 6 | w | Velocity along body z-axis (down) | m/s | Body |
| 7 | e0 | Quaternion scalar component | — | — |
| 8 | e1 | Quaternion x component | — | — |
| 9 | e2 | Quaternion y component | — | — |
| 10 | e3 | Quaternion z component | — | — |
| 11 | p | Roll rate | rad/s | Body |
| 12 | q | Pitch rate | rad/s | Body |
| 13 | r | Yaw rate | rad/s | Body |

### Quaternion convention

```
q = [e0, e1, e2, e3]  where e0 is the scalar component
```

Initialised from Euler angles using `Euler2Quaternion(phi, theta, psi)` — see `utils/Euler2Quaternion.m`.

### Initial conditions (from `stork_parameters.m`)

All states initialised to zero — aircraft at the origin, level, stationary, at 100m altitude (`pd0 = -100` in NED).

---

## Model Inputs

At this stage the state/pose model has no dynamic inputs — states are initialised from `stork_parameters.m` and held fixed. In the full simulation pipeline, inputs will come from the kinematic and dynamic models which compute state derivatives and integrate them forward in time.

---

## Model Outputs

The state vector `x` — all 13 elements — which is passed to:

- The **kinematic model** (Ch. 3) to compute position and attitude derivatives
- The **dynamic model** (Ch. 4) to compute velocity and angular rate derivatives
- The **spacecraft viewer** for real-time 3D visualisation

---

## How the Model Supports the Mission

The Stork VTOL is designed for autonomous fixed-wing cruise with VTOL capability. A complete and consistent state representation is fundamental to:

- **Navigation** — inertial position (pn, pe, pd) tracks the aircraft's location relative to the launch point
- **Guidance** — body-frame velocities (u, v, w) feed airspeed and angle-of-attack calculations
- **Control** — quaternion attitude and body angular rates (p, q, r) feed the autopilot's attitude controller
- **VTOL transitions** — the same state vector covers both hover and fixed-wing flight, making transition modelling possible without changing the state representation

---

## Limitations

- **No sensor model** — the state vector represents the true state. A real system would estimate these states from IMU, GPS, and airspeed sensors with associated noise and bias.
- **Flat Earth assumption** — introduces small errors for long-range missions (>50km). For the Stork's 100km+ range capability this may be non-negligible.
- **Rigid body assumption** — ignores wing flex and vibration from the VTOL motors, which could affect sensor readings in a real implementation.
- **Quaternion normalisation** — numerical integration can cause the quaternion norm to drift from 1.0 over time. A normalisation step should be added in the kinematic model.

---

## References

- Beard, R. W. & McLain, T. W. (2012). *Small Unmanned Aircraft: Theory and Practice*, Ch. 2. Princeton University Press.
- `utils/Euler2Quaternion.m` — quaternion initialisation
- `params/stork_parameters.m` — initial conditions
- `simulation/stork_pose_viewer.m` — viewer sanity check
- `docs/assumptions_table.md` — full parameter assumptions and sources

