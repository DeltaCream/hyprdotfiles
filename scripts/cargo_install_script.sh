#!/usr/bin/env bash

set -euo pipefail

# This script is meant for Rust/cargo installations, both libraries and binaries.
# As such, this will be separated between binaries and libraries.

# typst
cargo install --locked typst-cli
