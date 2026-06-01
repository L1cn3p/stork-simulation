# Flightory Stork VTOL — Flight Dynamics Simulation

UAV state, kinematic, and dynamic model for the Flightory Stork VTOL (4+1 quadplane), implemented in MATLAB/Simulink using the Beard-McLain framework.

---

## Project Structure

```
stork_simulation/
├── README.md
├── data/
│   ├── STORK-USER-MANUAL.pdf         # Flightory Stork base manual (CFD, geometry)
│   ├── STORK-USER-MANUAL-VTOL.pdf    # Flightory Stork VTOL manual (conversion, ArduPilot)
│   ├── s3021_polars.csv              # S3021 airfoil polar data (Re 200k, 500k)
│   └── motor_datasheet_notes.md      # BrotherHobby Avenger 2812 V5 910KV specs
├── params/
│   └── stork_parameters.m            # Beard-McLain parameter file for the Stork VTOL
└── notes/
    └── assumptions_table.md          # Full assumptions and sources for all parameters
```

The Beard-McLain `mavsim_public` repository sits alongside this repo (not nested inside it):

```
~/projects/
    stork_simulation/    ← this repo
    mavsim_public/       ← Beard-McLain repo (separate)
```

---

## Setup

**Requirements:** MATLAB with Simulink

1. Download or clone this repo, then clone the Beard-McLain repo alongside it:
   ```bash
   git clone https://github.com/byu-magicc/mavsim_public.git
   ```
2. Open MATLAB and set the `mavsim_public` root as your current folder
3. Right-click `mavsim_matlab` → Add to Path → Selected Folders and Subfolders
4. Do the same for `mavsim_simulink`
5. Run `savepath` in the Command Window to persist the paths
6. Copy `stork_parameters.m` into `mavsim_public/mavsim_matlab/parameters/`

---

## Aircraft

**Flightory Stork VTOL** — 3D-printed fixed-wing UAV with 4+1 quadplane VTOL conversion

| Parameter | Value | Source |
|-----------|-------|--------|
| Wingspan | 1620mm | Stork manual |
| Wing area | 31 dm² | Stork manual |
| MAC | 195mm | Stork manual |
| Aspect ratio | 8.3 | Stork manual |
| Airfoil | Selig S3021 | Stork manual |
| AUW | 1400–3100g (sim: 2.5kg) | Stork manual / estimated |
| Cruise speed | 50–70 km/h | Stork manual |
| CG | 47mm from leading edge | Stork manual |
| Pusher motor | BrotherHobby Avenger 2812 V5 910KV | Stork manual |
| Battery | 4S LiPo (sim baseline) | Stork manual |

**Note:** The simulation models fixed-wing cruise flight only. The 4 VTOL lift motors (T-Motor F90 1300KV) are outside the scope of the Beard-McLain fixed-wing dynamic model.

---

## Data Sources

| Data | Source |
|------|--------|
| Stork VTOL user manual | https://flightory.com/wp-content/uploads/2026/04/STORK-USER-MANUAL-VTOL.pdf |
| Stork base manual (CFD, geometry) | https://flightory.com/wp-content/uploads/2026/04/STORK-USER-MANUAL.pdf |
| S3021 airfoil polars | http://airfoiltools.com/airfoil/details?airfoil=s3021-il |
| BrotherHobby motor spec | https://www.brotherhobbystore.com/products/brotherhobby-avenger-2812-v5-910kv-motorcw-178 |
| Beard-McLain mavsim_public repo | https://github.com/byu-magicc/mavsim_public (main branch, last updated Mar 2026) |

---

## Parameter Status

14 parameters are measured or derived from published data. 31 are estimated. See `notes/assumptions_table.md` for full details, sources, and recommended future work to improve fidelity.

---

## References

- Beard, R. W. & McLain, T. W. (2012). *Small Unmanned Aircraft: Theory and Practice*. Princeton University Press.
- BYU MAGICC Lab. *mavsim_public* (2026). https://github.com/byu-magicc/mavsim_public
- Flightory by Szymon Wójcik. *Stork User Manual V.2* (2026). flightory.com
- Selig, M. S. *UIUC Airfoil Coordinates Database*. University of Illinois Urbana-Champaign.

