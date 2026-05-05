# CoolerControl Configuration

This directory contains the configuration for `coolercontrol`, used to manage the **NZXT Kraken Z53** AIO and fan curves on Arch Linux, specifically tuned for an **Intel i9-13900K**.

## Path Location
- **System Path:** `/etc/coolercontrol/config.toml`
- **Dotfiles Path:** `mydotfiles/extras/etc/coolercontrol/config.toml`

## Hardware Context
- **CPU:** Intel Core i9-13900K (High thermal output)
- **Cooler:** NZXT Kraken Z53 (240mm AIO)
- **Sensor Source:** Liquid Temperature (Coolant)

## Setup Overview
This configuration is designed for a **silent yet responsive** system using Liquid Temperature as the primary sensor.

### 1. Liquid Smooth Function (Fans)
Applied to NZXT fans to prevent "revving" noise during CPU spikes.
- **Ramping:** Asymmetric
  - **Max Increasing:** 5% - 10% (Glides up to target)
  - **Max Decreasing:** 1% - 2% (Slow, quiet wind-down)
- **Hysteresis:** 2.0°C with a 2s delay to ignore minor temperature wobbles.
- **Threshold Hopping:** OFF (Maintains gradual transitions).

### 2. Pump Performance Profile (Z53)
Applied to the Kraken Z53 Pump for consistent flow.
- **Logic:** High floor (70%) to avoid mechanical whine and maximize heat transfer.
- **Nodes:**
  - 30°C Liquid -> 70%
  - 35°C Liquid -> 85%
  - 42°C Liquid -> 100%
- **Function:** "Pump Direct" (Standard type) with Threshold Hopping **ON** for immediate response.

### 3. Hardware Fixes (The "Wake-up" Bug)
To prevent the Z53 controller from sticking at 58% or failing after system sleep:
- **Service Restart:** Ensure the systemd resume hook is active:
  - `systemctl restart coolercontrold.service` on wake.
- **Command Delay:** Set to `20ms` in device settings within the GUI to prevent USB communication lockups.

## Restoration Instructions
1. Install `coolercontrol` (AUR).
2. Stop the daemon: `sudo systemctl stop coolercontrold`.
3. Copy this config: `sudo cp config.toml /etc/coolercontrol/config.toml`.
4. Start the daemon: `sudo systemctl start coolercontrold`.
