#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up Distrobox + CrashPlan"
"${SCRIPT_DIR}/install-distrobox.sh"

echo "==> Installing launcher symlink"
"${SCRIPT_DIR}/install-symlink.sh"

echo "==> Installing autostart desktop entry"
"${SCRIPT_DIR}/install-desktop.sh"

echo "==> Done."
