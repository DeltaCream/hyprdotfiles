#!/usr/bin/env bash

# exit on errors
set -euo pipefail

SOURCE="./minesddm"
DESTINATION="/usr/share/sddm/themes/"

# Set green text for terminal output
GREEN="\033[0;32m"
NC="\033[0m" # No color

echo -e "${GREEN}Copying Minecraft select screen for SDDM...${NC}"
sudo cp -r "$SOURCE" "$DESTINATION"
echo -e "${GREEN}Done! Please set your theme at /etc/sddm.conf with Current=minesddm, then log out of your system to see your changes!${NC}"
