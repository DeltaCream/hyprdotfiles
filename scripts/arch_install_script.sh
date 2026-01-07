#!/usr/bin/env bash

set -euo pipefail

# This file is separated into two parts: one for packages that are common to all distributions and one for packages that are from the Arch User Repository (AUR).
# For the former, we will use pacman, and for the latter, we will use paru.

sudo pacman -Syu install "${PACKAGES[@]}"

sudo paru -Syu "${AUR_PACKAGES[@]}"
