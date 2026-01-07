#!/usr/bin/env bash

set -euo pipefail

# Colors (optional)
BLUE='\e[34m'
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No color

echo -e "${BLUE}=== Fedora Setup Script ===${NC}"

# -----------------------------
# 1. Update system
# -----------------------------

echo -e "${GREEN}Updating system...${NC}"
sudo dnf upgrade --refresh -y

# -----------------------------
# 2. Install software packages
# -----------------------------

PACKAGES=(
    # very first ones, example by ChatGPT
    git
    vlc
    neovim

    # Valkey as an open-source substitute for Redis
    valkey
    valkey-compat-redis # For symlinked binaries to redis-cli and redis-server
    valkey-doc # For valkey-doc (can be used with man, e.g. `man hgetall`, `man valkey.conf`, etc.)

    # Command-line tools
    bat # cat alternative
    fd # find alternative
    ripgrep # grep alternative
    alacritty # Rust terminal emulator
    cmatrix # Matrix-inspired screen saver
    tealdeer # Rust implementation of tldr

    # Utilities
    blender
    krita
    gimp
    obs-studio
    audacity

    # Image Utiltiies
    digikam # open-source digital photo editor and manager

    # — Torrent and File Sharing ---
    qbittorrent

    # Miscellaneous stuff
    minuet

    # freyr-js set-up
    AtomicParsley

    # Gaming
    steam
    lutris
    wine
    retroarch
    wine-mono
    winetricks
)

echo -e "${GREEN}Installing packages...${NC}"
sudo dnf install -y "${PACKAGES[@]}"

echo -e "${GREEN}All Flatpak applications installed successfully!${NC}"
