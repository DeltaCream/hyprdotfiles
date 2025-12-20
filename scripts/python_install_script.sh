#!/usr/bin/env bash
set -e  # exit on error

# 1. Optional: update system packages (on Fedora)
sudo dnf update --refresh
sudo dnf install -y python3 python3-pip curl

# 2. Install uv (via pip)
# pip install --user uv

# Alternatively, using the uv installer:
curl -LsSf https://astral.sh/uv/install.sh | sh

# 3. Use uv (or pip) to install Savify
# If using uv:
~/.local/bin/uv pip install savify

# If not using uv:
# pip install --user savify

echo "All Python packages have been installed!"
