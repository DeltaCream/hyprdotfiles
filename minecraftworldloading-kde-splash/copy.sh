#!/usr/bin/env bash

# exit on errors
set -euo pipefail

SOURCE="."
DESTINATION="~/.local/share/plasma/look-and-feel/minecraftworldloading-kde-splash"

# Set green text for terminal output
GREEN="\033[0;32m"
NC="\033[0m" # No color

echo -e "${GREEN}Copying Minecraft loading screen for KDE Splash...${NC}"
cp -r "$SOURCE" "$DESTINATION"
echo -e "${GREEN}Done! Please set your splash screen on KDE System Settings!${NC}"
