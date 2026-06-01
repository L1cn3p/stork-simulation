# Assumptions Table — Flightory Stork VTOL Simulation Parameters

**Project:** UAV State/Kinematic/Dynamic Model — Beard-McLain Framework  
**Aircraft:** Flightory Stork VTOL (4+1 quadplane configuration)  
**Date:** June 2026  
**Framework:** Beard-McLain *Small Unmanned Aircraft: Theory and Practice*, uavbook repo  

---

## How to read this table

- **Measured / datasheet** — value comes directly from a published source with no modification
- **Read from chart** — value extracted by visual inspection of a graph (inherent reading uncertainty ~5–10%)
- **Derived** — calculated from measured values using a standard formula
- **Estimated** — value approximated using engineering judgment, physical models, or retained from Aerosonde reference; should be refined if higher fidelity is required

---

## Section 1 — Physical Parameters

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Mass (AUW) | `MAV.mass` | 2.5 kg | **Estimated** | Manual states AUW range 1400–3100g. 2.5kg estimated for a complete 4S VTOL build including battery, motors, ESCs, FC, and wiring. Actual mass depends on build. | Flightory Stork VTOL Manual V.2, p.5 |
| Roll inertia | `MAV.Jx` | 0.0822 kg·m² | **Estimated** | Wing modelled as thin rectangular plate: (1/12)·m·b² scaled to wing mass fraction. | Geometric approximation |
| Pitch inertia | `MAV.Jy` | 0.0785 kg·m² | **Estimated** | Fuselage modelled as slender rod: (1/12)·m·L² where L = 1.0m. | Geometric approximation |
| Yaw inertia | `MAV.Jz` | 0.1365 kg·m² | **Estimated** | Approximated as Jx + Jy (perpendicular axis theorem for flat plate). | Geometric approximation |
| Cross inertia | `MAV.Jxz` | 0.0050 kg·m² | **Estimated** | Assumed near-zero for a symmetric airframe with no significant mass offset. | Standard assumption for symmetric UAV |

---

## Section 2 — Geometric Parameters

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Wing area | `MAV.S_wing` | 0.31 m² | **Measured** | Manual states 31 dm² | Flightory Stork Manual V.2, p.5 |
| Wingspan | `MAV.b` | 1.620 m | **Measured** | Manual states 1620mm | Flightory Stork Manual V.2, p.5 |
| Mean aerodynamic chord | `MAV.c` | 0.195 m | **Measured** | Manual states MAC = 195mm | Flightory Stork Manual V.2, p.5 |
| Aspect ratio | `MAV.AR` | 8.45 (auto-calc) | **Derived** | AR = b²/S = 1.620²/0.31. Manual states 8.3 (minor rounding difference due to taper). | Flightory Stork Manual V.2, p.5 |
| Oswald efficiency | `MAV.e` | 0.85 | **Estimated** | Rectangular wing with AR 8.3. e = 0.85 is typical for a straight untapered wing; Aerosonde used 0.9 which is optimistic for this geometry. | Standard aerodynamic reference |
| Air density | `MAV.rho` | 1.225 kg/m³ | **Measured** | ISA standard sea level, 15°C | ICAO Standard Atmosphere |

---

## Section 3 — Lift Coefficients

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Zero-AoA lift | `MAV.C_L_0` | 0.02 | **Read from chart** | Read from Stork whole-aircraft CFD chart (CL vs CD), CL at minimum drag point (~α = 0°). Reading uncertainty ±0.01. | Flightory Stork Manual V.2, p.7 |
| Lift curve slope | `MAV.C_L_alpha` | 5.55 /rad | **Derived** | Computed from S3021 polar data at Re=200,000: ΔCL/Δα = (0.9440−0.3623)/(6°−0°) = 0.0970/deg × 57.3 = 5.55/rad | S3021 polar data, airfoiltools.com, Re=200k |
| Pitch-rate lift | `MAV.C_L_q` | 7.95 | **Estimated** | Retained from Aerosonde reference. No Stork-specific dynamic derivative data available. | Beard-McLain Aerosonde reference |
| Elevator lift | `MAV.C_L_delta_e` | 0.13 | **Estimated** | Retained from Aerosonde. V-tail ruddervator geometry not analytically modelled. | Beard-McLain Aerosonde reference |

---

## Section 4 — Drag Coefficients

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Zero-lift drag | `MAV.C_D_0` | 0.0139 | **Derived** | From S3021 polar at Re=200k, CD at α=−3° where CL≈0. Consistent with visual reading of Stork CFD chart minimum CD (~0.012–0.015). | S3021 polar data, airfoiltools.com, Re=200k |
| Drag due to AoA | `MAV.C_D_alpha` | 0.0334 /rad | **Derived** | Computed from S3021 polar: ΔCD/Δα = (0.0127−0.0092)/(6°−0°) = 0.000583/deg × 57.3 = 0.0334/rad | S3021 polar data, airfoiltools.com, Re=200k |
| Roll-rate drag | `MAV.C_D_p` | 0.0 | **Estimated** | Assumed negligible — standard simplification in Beard-McLain framework | Standard assumption |
| Pitch-rate drag | `MAV.C_D_q` | 0.0 | **Estimated** | Assumed negligible — standard simplification in Beard-McLain framework | Standard assumption |
| Elevator drag | `MAV.C_D_delta_e` | 0.0135 | **Estimated** | Retained from Aerosonde. V-tail ruddervator data unavailable; proper derivation requires AVL analysis of tail geometry. | Beard-McLain Aerosonde reference |

---

## Section 5 — Pitching Moment Coefficients

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Zero-AoA moment | `MAV.C_m_0` | 0.0 | **Read from chart** | Stork CFD chart (Cm vs Alpha) shows Cm crosses zero at α≈0°. Confirmed by manual text: "virtually no pitching moment at zero degrees angle of attack." | Flightory Stork Manual V.2, p.6–7 |
| Pitch moment slope | `MAV.C_m_alpha` | −1.79 /rad | **Read from chart** | Linear slope read from Stork CFD chart: approximately −0.0312 Cm/deg × 57.3 = −1.79/rad. Negative slope confirms static pitch stability. | Flightory Stork Manual V.2, p.7 |
| Pitch damping | `MAV.C_m_q` | −38.21 | **Estimated** | Retained from Aerosonde. Requires tail volume coefficient analysis using V-tail geometry (spars: 8×155mm, 6×265mm) for proper derivation. | Beard-McLain Aerosonde reference |
| Elevator moment | `MAV.C_m_delta_e` | −0.99 | **Estimated** | Retained from Aerosonde. V-tail ruddervator data unavailable. | Beard-McLain Aerosonde reference |

---

## Section 6 — Lateral/Directional Coefficients

All lateral and directional coefficients are retained from the Beard-McLain Aerosonde reference. No Stork-specific data is available for these parameters. Proper derivation would require AVL (Athena Vortex Lattice) analysis using the Stork's V-tail geometry, or dedicated lateral CFD.

| Parameter | Variable | Value | Status |
|-----------|----------|-------|--------|
| Side force (beta) | `MAV.C_Y_beta` | −0.83 | **Estimated** |
| Side force (aileron) | `MAV.C_Y_delta_a` | 0.075 | **Estimated** |
| Side force (rudder) | `MAV.C_Y_delta_r` | 0.19 | **Estimated** |
| Roll moment (beta) | `MAV.C_ell_beta` | −0.13 | **Estimated** |
| Roll moment (p) | `MAV.C_ell_p` | −0.51 | **Estimated** |
| Roll moment (r) | `MAV.C_ell_r` | 0.045 | **Estimated** |
| Roll moment (aileron) | `MAV.C_ell_delta_a` | 0.17 | **Estimated** |
| Roll moment (rudder) | `MAV.C_ell_delta_r` | 0.0024 | **Estimated** |
| Yaw moment (beta) | `MAV.C_n_beta` | 0.073 | **Estimated** |
| Yaw moment (p) | `MAV.C_n_p` | −0.069 | **Estimated** |
| Yaw moment (r) | `MAV.C_n_r` | −0.095 | **Estimated** |
| Yaw moment (aileron) | `MAV.C_n_delta_a` | −0.011 | **Estimated** |
| Yaw moment (rudder) | `MAV.C_n_delta_r` | −0.069 | **Estimated** |

---

## Section 7 — Propulsion Parameters

| Parameter | Variable | Value | Status | Basis | Source |
|-----------|----------|-------|--------|-------|--------|
| Prop diameter | `MAV.D_prop` | 0.254 m (10 in) | **Measured** | Manual recommends 10×6 two-blade propeller for 4S operation | Flightory Stork Manual V.2, p.14 |
| Prop disk area | `MAV.S_prop` | 0.0507 m² | **Derived** | Auto-calculated: π×(D/2)² = π×(0.127)² | Derived from D_prop |
| Motor KV | `MAV.K_V` | 910 RPM/V | **Measured** | From BrotherHobby official specification | brotherhobbystore.com |
| Motor torque constant | `MAV.KQ` | derived | **Derived** | KQ = (1/KV)×60/(2π) — standard relationship | Derived from K_V |
| Motor resistance | `MAV.R_motor` | 0.10 Ω | **Estimated** | Typical internal resistance for a 2812-class brushless motor. Not published by manufacturer. | Engineering estimate |
| No-load current | `MAV.i0` | 1.5 A | **Estimated** | Typical no-load current for motors of this class. Not published by manufacturer. | Engineering estimate |
| Battery cells | `MAV.ncells` | 4 | **Estimated** | 4S configuration assumed for simulation baseline (lighter, efficient cruise). Manual supports 4S or 6S. | Flightory Stork Manual V.2, p.14 |
| Max voltage | `MAV.V_max` | 14.8 V | **Derived** | V_max = 3.7 × ncells | Derived from ncells |
| CT/CQ coefficients | `MAV.C_T*`, `MAV.C_Q*` | Aerosonde values | **Estimated** | Placeholder values from Aerosonde. Should be replaced with values fitted to 10×6 prop data from UIUC propeller database (https://m-selig.ae.illinois.edu/props/propDB.html) | Beard-McLain Aerosonde reference |

---

## Summary of Estimated vs Measured Values

| Category | Measured/Derived | Estimated |
|----------|-----------------|-----------|
| Physical parameters | 0 | 5 |
| Geometry | 4 | 2 |
| Lift coefficients | 2 | 2 |
| Drag coefficients | 2 | 3 |
| Pitch moment | 2 | 2 |
| Lateral/directional | 0 | 13 |
| Propulsion | 4 | 4 |
| **Total** | **14** | **31** |

The high estimated count for lateral/directional coefficients is expected and consistent with the available data — whole-aircraft lateral CFD or AVL analysis would be required to improve these. The parameters most critical to fixed-wing cruise simulation fidelity (CL, CD, Cm, and geometry) are either measured or derived from actual Stork CFD and polar data.

---

## Recommended Future Work

1. Run AVL analysis on V-tail geometry (spars: 8×155mm, 6×265mm, dihedral angle from assembly drawings) to derive proper V-tail coefficients
2. Weigh completed VTOL build to replace estimated mass with measured value
3. Fit CT/CQ polynomial to 10×6 prop data from UIUC propeller database
4. Obtain motor resistance and no-load current from direct measurement or manufacturer contact
5. Consider running full 3D CFD on assembled Stork geometry to validate whole-aircraft aerodynamic coefficients

