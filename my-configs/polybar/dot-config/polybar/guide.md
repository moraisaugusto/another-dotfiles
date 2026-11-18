## Short answer

Nothing in the kernel log will ever show this, which is why your `journalctl -kf | grep nvrm` watch is silent: link re-training, mode re-validation and flip problems are logged by the **X driver in `/var/log/Xorg.0.log`**, not by NVRM. And the evidence points at the X11 presentation path, not at the cable or the panel.

Two prime suspects, both X11-only (which matches Windows + sway being clean):

1. **`ForceCompositionPipeline=On` is being force-stamped on DP-4** (and DP-2) by a stale `/etc/X11/xorg.conf` from driver **535.113.01** (you're on **615.78.08** now). It adds an extra full-frame GPU composition pass before scanout on a 4K120 output that's already at the DP 1.4 bandwidth ceiling. This is a classic flicker/black-blink source and it's redundant with picom.
2. **VRR/G-SYNC is enabled on the X screen** — `AllowVRR = 1` and `AllowGSYNC = 1`. On X11 the driver toggles the output timing per-frame; brightness-pulsing flicker at high refresh is the textbook symptom. sway only enables adaptive sync if you ask for it per output, and Windows likely has it off for desktop — so neither flickers.

## What I found on your actual machine

| Finding | Value | Why it matters |
|---|---|---|
| Session | `XDG_SESSION_TYPE=x11`, i3 + picom 13 | X11-only path |
| GPU / driver | RTX 4090, **nvidia-open 615.78.08** (GSP) | open module, very recent |
| Monitors | 2× ROG **XG27UQ** (4K 144 Hz, EDID identical) | both max out near DP1.4 bandwidth |
| Current rate | both at 60 Hz (`display_manager.sh` hardcodes `REFRESH_RATE="60"`) | 120 only happens when you switch manually |
| Active metamode | `DPY-3 … ForceCompositionPipeline=On, DPY-5 … ForceCompositionPipeline=On` | **FCP off would be the default; it's forced on** |
| `AllowVRR` / `AllowGSYNC` | **1 / 1** | VRR active on the X screen |
| `/etc/X11/xorg.conf` | from 535, `metamodes` references `DP-0`/`DP-2`, `HorizSync 329.0 - 329.0`, `nvidiaXineramaInfoOrder DFP-1` | stale + bogus; driver still applies `Option "MetaModes"` (confirmed in Xorg log line 98) |
| Xorg log | mode list for DP-2 got **invalidated and removed at t=4823s** ("could not be re-validated"), and 20 mode-sets total | mode re-validation churn, all at 120 Hz |
| picom | `backend = "xrender"`, `vsync = false`, `dual_kawase` blur | `vsync` is **glx-only**, so your "temporary fix" was a no-op; blur is silently unsupported and disabled (log spams it) |

Note on picom: it can produce tearing/judder, but it cannot blank a monitor's link. If what you see is a *whole-screen black blink*, FCP/link timing is the better fit; if it's brightness pulsing, it's VRR; if it's a tearing/rolling band, it's picom.

## Test ladder (each step isolated, ~15–30 min since it's intermittent)

**0. Catch the event.** Keep this running while flicker happens:
```bash
tail -F /var/log/Xorg.0.log | grep -E "Setting mode|MetaMode|EDID|NVIDIA\(0\)"
```
If a flicker lines up with a `Setting mode` / `MetaMode … could not be re-validated`, it's the driver/link, not picom. If the log stays silent, it's the compositor path.

**1. 120 Hz, picom off.**
```bash
pkill picom
xrandr --output DP-4 --mode 3840x2160 --rate 120
```
Then relaunch in the foreground with `--backend glx --vsync --log-level=debug` and compare.

**2. Drop FCP and VRR live (no reboot needed).**
```bash
nvidia-settings -q CurrentMetaMode -t        # copy & edit the string
nvidia-settings -a 'CurrentMetaMode=DPY-3: nvidia-auto-select @3840x2160 +0+0, DPY-5: nvidia-auto-select @3840x2160 +3840+0'
nvidia-settings -a AllowVRR=0 -a AllowGSYNC=0
```
If flicker disappears here, you've found it. Also try only one of the two changes at a time so you know which one.

**3. Bandwidth/margin test.** Set DP-4 to `3840x2160 @ 100` (or 98). 4K120 8bpc is ~25.3 Gbps vs HBR3's 25.92 — razor thin. Vanishes at 100 Hz → link-training/PHY margin, not software.

**4. Port swap at the GPU.** Not a cable test — swap which monitor is on DP-2 vs DP-4. Flicker follows the monitor → monitor OSD (Adaptive-Sync, DSC, 144 Hz overclock). Stays on DP-4 → GPU output/link.

**5. Driver fallback.** 615.78.08 is new and open-module; try `nvidia` (proprietary) or a 580.x LTS build. Keep a TTY handy.

## Permanent cleanup I'd do regardless

- Back up and **delete `/etc/X11/xorg.conf`**. It's from 535, references a port (`DP-0`) that doesn't exist, and a nonsensical `HorizSync 329.0 - 329.0`. Let `xrandr` + `nvidia-settings` own modes; if you need FCP later, set it per-output deliberately.
- Fix `display_manager.sh`: `REFRESH_RATE` as a parameter/arg, not a hardcoded 60.
- picom: pick **glx** backend if you want people's blur/dual_kawase back, then actually set `vsync`; drop the misleading comment about 120 Hz.

One question so I can narrow it before you start: when it "flicks", is it **the whole screen going black for a split second**, **a brightness/contrast pulse**, or **a tearing/shearing band**? That single detail decides whether we chase link/FCP or VRR.
