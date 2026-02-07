#!/usr/bin/env bash
#rofi -show drun

# --------------------------------------------------------
# === 1. Launch Vicinae and capture its active window ===
# --------------------------------------------------------
vicinae open
# sleep 0.05  # Small delay if needed to ensure window is mapped.
#             # Uncomment this ^ line if neede for your case, not needed for my setup.
vicinae_win=$(xdotool getactivewindow)

# --------------------------------------------------------
# === 2. Get mouse position (just to detect monitor) ===
# --------------------------------------------------------
eval "$(xdotool getmouselocation --shell)"  # You will get saved mouse coordinates as $X and $Y

# -----------------------------------------
# === 3. Detect monitor under pointer ===
# -----------------------------------------
MONITOR_LINE=$(xrandr --query | grep " connected" | grep -v disconnected | awk -v mx=$X -v my=$Y '
{
    for(i=1;i<=NF;i++){
        if ($i ~ /^[0-9]+x[0-9]+\+[0-9]+\+[0-9]+$/){
            split($i,a,/[\+x]/);
            W=a[1]; H=a[2]; X0=a[3]; Y0=a[4];
            if (mx>=X0 && mx<X0+W && my>=Y0 && my<Y0+H){
                print $1,X0,Y0,W,H;
                exit
            }
        }
    }
}')

# -------------------------------
# === 4. Parse monitor info ===
# -------------------------------
read MON_NAME MON_X MON_Y MON_W MON_H <<< "$MONITOR_LINE"

# ---------------------------------------------------------------
# === 5. Vicinae window size ===
# Below values are hardcoded for Vicinae's default window size.
# You may adjust them if you changed Vicinae's window size.
# You can also get it dynamically with:
# eval $(xdotool getwindowgeometry --shell $vicinae_win)
# ---------------------------------------------------------------
WIN_W=770
WIN_H=480

# --------------------------------------------------------------------------
# === 6. Compute top-left coordinates to center Vicinae on the monitor ===
# --------------------------------------------------------------------------
NEW_X=$(( MON_X + (MON_W - WIN_W)/2 ))
NEW_Y=$(( MON_Y + (MON_H - WIN_H)/2 ))

# --------------------------------
# === 7. Move Vicinae window ===
# --------------------------------
xdotool windowmove "$vicinae_win" "$NEW_X" "$NEW_Y"
