#!/usr/bin/env bash
# ~/.config/waybar/scripts/blue_toggle.sh
# if pgrep -x "hyprsunset" >/dev/null; then
# if pgrep -x hyprsunset >/dev/null; then
#   pkill hyprsunset
#   echo "󰈋 off"   # or any visual cue
# else
#   hyprsunset &  # or wlsunset
#   echo "󰈋 on"
# fi

# Get current CTM state: if it's identity, no filter; else filter active
current=$(hyprctl hyprsunset temperature)

if [[ "$current" == "identity" || "$current" == "6500"* ]]; then
  # hyprsunset &  # or wlsunset
  hyprctl hyprsunset temperature 4500 # change to any temperature (2500, 4500, any other number)
  echo "󰈋 on"
else
  # pkill hyprsunset
  hyprctl hyprsunset identity
  echo "󰈋 off"   # or any visual cue
fi

# echo "toggled: $(date)" >&2
# exec echo "🟦"
