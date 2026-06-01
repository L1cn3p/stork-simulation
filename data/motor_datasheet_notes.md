# Pusher Motor Data — BrotherHobby Avenger 2812 V5 910KV

**Role in Stork VTOL:** Pusher motor only. Drives fixed-wing forward flight.  
**The 4 VTOL lift motors (T-Motor F90 1300KV) are NOT modelled here — they are outside the scope of the Beard-McLain fixed-wing dynamic model.**

---

## Official Specifications

| Parameter | Value | Source |
|-----------|-------|--------|
| Model | BrotherHobby Avenger 2812 V5 | brotherhobbystore.com |
| KV | 910 RPM/V | Official spec |
| Configuration | 12N14P | Official spec |
| Rated cells | 6S LiPo | Official spec |
| Weight | 79g (with 25cm wires) | Official spec |
| Bolt pattern | M3, 19×19mm | Official spec |
| Shaft thread | M5 | Official spec |
| Casing | Al 7075 | Official spec |
| Magnets | N52H arc magnets | Official spec |

Source: https://www.brotherhobbystore.com/products/brotherhobby-avenger-2812-v5-910kv-motorcw-178

---

## Thrust Data

From Flightory Stork User Manual V.2 (flightory.com, p.13):

| Configuration | Prop | Max Thrust | Max Power | Max Current |
|--------------|------|-----------|-----------|-------------|
| 6S | 9453 tri-blade | ~3800g | ~1280W | ~50A |
| 4S | 10×6 two-blade | ~2000g | — | 35–40A (ESC rating) |

Note: The manual states prototype testing confirmed cruise throttle below 50% on 4S with 10×6 propellers.

---

## Simulation Configuration (4S assumed)

The simulation uses the 4S configuration as the baseline — lighter, more efficient at cruise, and consistent with the mid-range AUW estimate of 2.5kg.

| Parameter | Value | Notes |
|-----------|-------|-------|
| Battery cells | 4S | 4S assumed (lighter configuration per manual) |
| V_max | 14.8V | 4 × 3.7V nominal |
| Prop diameter | 10 inches = 0.254m | Manual: 10×6 two-blade on 4S |
| S_prop (disk area) | 0.0507 m² | π × (0.127)² |
| Max static thrust | ~2000g = 19.6N | From Stork manual, 4S config |
| KV | 910 RPM/V | From official spec |

---

## Estimated Parameters (not published by manufacturer)

The following values are standard estimates for a 2812-class motor and are flagged in stork_parameters.m:

| Parameter | Estimated Value | Basis |
|-----------|----------------|-------|
| R_motor | 0.10 Ω | Typical for 2812 class motor (larger stator = lower resistance than Aerosonde ref) |
| i0 (no-load current) | 1.5A | Typical for motors of this class |
| KQ | derived from KV | KQ = (1/KV) × 60/(2π) |

---

## Prop Data Fit Coefficients (C_T, C_Q)

The C_T and C_Q polynomial coefficients for the 10×6 two-blade prop are not available from manufacturer data. The Aerosonde placeholder values are retained and flagged for replacement if prop performance data becomes available (e.g. from UIUC propeller database or direct measurement).

---

## References

1. BrotherHobby Avenger 2812 V5 910KV official spec — https://www.brotherhobbystore.com/products/brotherhobby-avenger-2812-v5-910kv-motorcw-178
2. Flightory Stork User Manual V.2, Powertrain Selection section (pp.13–14) — https://flightory.com/wp-content/uploads/2026/04/STORK-USER-MANUAL.pdf
3. Flightory Stork VTOL User Manual V.2, Powertrain Selection section (pp.11–13) — https://flightory.com/wp-content/uploads/2026/04/STORK-USER-MANUAL-VTOL.pdf

