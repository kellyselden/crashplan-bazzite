#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

rm --force "${LAUNCHER_PATH}" || true
rm --force "${DESKTOP_PATH}" || true

read -r -p "Remove container '${CONTAINER_NAME}'? [y/N]: " answer

if [[ "${answer}" =~ ^[Yy]$ ]]; then
  distrobox rm "${CONTAINER_NAME}" --force
fi

echo "Uninstall complete."
