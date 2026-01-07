#!/usr/bin/env bash

# exit on errors
set -euo pipefail

# First install the requirements (if not yet downloaded)
# install rustup for Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# install bun for JavaScript via tauri
# curl -fsSL https://bun.sh/install | bash
# a node build tool somehow needed
# npm install -g node-gyp

# Switch to source build directory
cd "/home/cream/Documents/sourcebuild"

# Clone the repository
git clone https://github.com/spacedriveapp/spacedrive
cd spacedrive

# Install dependencies
bun install
cargo run -p xtask -- setup  # generates .cargo/config.toml with aliases
cargo build # builds all core and apps (including the daemon and cli)

# Copy dependencies into the debug Folder ( probably windows only )
# Copy-Item -Path "apps\.deps\lib\*.dll" -Destination "target\debug" -ErrorAction SilentlyContinue
# Copy-Item -Path "apps\.deps\bin\*.dll" -Destination "target\debug" -ErrorAction SilentlyContinue

# Run the desktop app (automatically starts daemon)
cd apps/tauri
bun run tauri:dev
