#!/usr/bin/env bash

# exit on errors
set -euo pipefail

gsettings set org.gnome.desktop.interface color-scheme \'prefer-dark\' # turn on dark theme

# set accent color from the following choices: blue, orange, purple, slate, yellow, green, pink, red, teal
COLOR='blue'

gsettings set org.gnome.desktop.interface accent-color \'${COLOR}\'

# section below: determine location of source and target relevant to the script
SCRIPT_PATH="${BASH_SOURCE[0]}"

# Prefer readlink -f (Linux) / realpath if available; otherwise make absolute via $PWD
if command -v readlink >/dev/null 2>&1; then
  # readlink -f resolves symlinks and returns absolute path
  SCRIPT_PATH="$(readlink -f "$SCRIPT_PATH" 2>/dev/null || true)"
fi

if [ -z "${SCRIPT_PATH:-}" ] || [[ "$SCRIPT_PATH" != /* ]]; then
  # fallback: make absolute relative to current working directory
  SCRIPT_PATH="$PWD/${BASH_SOURCE[0]}"
fi

# Terminal output color
GREEN="\033[0;32m"
NC="\033[0m" # no color

# directory containing the directory containing script.sh
ROOT_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd -P)"

ICONS=(
    lock.svg
    hibernate.svg
    logout.svg
    shutdown.svg
    suspend.svg
    reboot.svg
)

for f in "${ICONS[@]}"; do
  SRC="$ROOT_DIR/wleave/icons/$f"
  TARGET="/usr/share/wleave/icons/$f"

  # ensure directory of target exists (WILL USE SUDO AS IT IS IN usr/share!!!)
  sudo mkdir -p "$(dirname "$TARGET")"

  # copy, still uses sudo due to the target location being at usr/share
  sudo cp "$SRC" "$TARGET"
  echo -e "${GREEN}Copied image:${NC} $SRC -> $TARGET)"
done
