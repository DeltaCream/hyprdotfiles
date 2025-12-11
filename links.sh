#!/usr/bin/env bash

# exit on errors
set -euo pipefail

# Colors (optional)
BLUE='\e[34m'
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" # No color

echo -e "${BLUE}=== Hyprdotfiles Setup Script ===${NC}"

echo -e "${GREEN}Creating symlinks for Hyprland configs...${NC}"

# directory containing script.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# list of config files to link (basename only)
FILES=(
  hyprland.conf
  hypridle.conf
  hyprlock.conf
  hyprpaper.conf
)

# ln -s "$SCRIPT_DIR/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
# ln -s "$SCRIPT_DIR/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
# ln -s "$SCRIPT_DIR/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
# ln -s "$SCRIPT_DIR/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"

for f in "${FILES[@]}"; do
  SRC="$SCRIPT_DIR/hypr/$f"
  LINK="$HOME/.config/hypr/$f"

  # ensure parent exists
  mkdir -p "$(dirname "$LINK")"

  # if there's already a symlink there
  if [ -L "$LINK" ]; then
    if command -v realpath >/dev/null 2>&1; then
      # resolve absolute canonical paths for reliable comparison
      ABS_SRC="$(realpath -m "$SRC")"
      # readlink may be relative; make it absolute relative to link's dir
      LINK_TARGET="$(readlink "$LINK")"
      ABS_LINK_TARGET="$(realpath -m "$(dirname "$LINK")/$LINK_TARGET")"
      if [ "$ABS_LINK_TARGET" = "$ABS_SRC" ]; then
        echo -e "${YELLOW}Skipping (correct symlink exists):${NC} $LINK -> $LINK_TARGET"
        continue
      else
        echo -e "${YELLOW}Skipping (symlink exists but points to different target):${NC} $LINK -> $LINK_TARGET"
        continue
      fi
    else
      # fallback: compare the raw readlink text with SRC (less robust)
      if [ "$(readlink "$LINK")" = "$SRC" ]; then
        echo -e "${YELLOW}Skipping (correct symlink exists):${NC} $LINK -> $(readlink "$LINK")"
        continue
      else
        echo -e "${YELLOW}Skipping (symlink exists but points elsewhere):${NC} $LINK -> $(readlink "$LINK")"
        continue
      fi
    fi
  fi

  # if a non-symlink file or directory exists at LINK, skip (don't overwrite)
  if [ -e "$LINK" ]; then
    echo -e "${YELLOW}Skipping (path exists and is not a symlink):${NC} $LINK"
    continue
  fi

  # create the symlink (relative if possible)
  if command -v realpath >/dev/null 2>&1 && realpath --help 2>&1 | grep -q -- '--relative-to'; then
    ABS_SRC="$(realpath -m "$SRC")"
    REL_SRC="$(realpath --relative-to="$(dirname "$LINK")" "$ABS_SRC")"
    ln -s "$REL_SRC" "$LINK"
  else
    ln -s "$SRC" "$LINK"
  fi

  echo -e "${GREEN}Created symlink:${NC} $LINK -> $(readlink "$LINK")"
done

# ---------

echo -e "${GREEN}Creating symlink for waybar folder...${NC}"
# ln -s "$SCRIPT_DIR/waybar" "$HOME/.config/waybar"

SRC="$SCRIPT_DIR/waybar"
DEST="$HOME/.config/waybar"

mkdir -p "$(dirname "$DEST")"

# Replace any existing file/symlink and force treat DEST as file (not directory)
ln -sTfn "$SRC" "$DEST"

# --------

echo -e "${GREEN}Creating symlink for hyprlock folder...${NC}"
# ln -s "$SCRIPT_DIR/hypr/hyprlock" "$HOME/.config/hypr/hyprlock"

SRC="$SCRIPT_DIR/hypr/hyprlock"
DEST="$HOME/.config/hypr/hyprlock"

mkdir -p "$(dirname "$DEST")"

# Replace any existing file/symlink and force treat DEST as file (not directory)
ln -sTfn "$SRC" "$DEST"

echo -e "${GREEN}Setup complete!${NC}"
