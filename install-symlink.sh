#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

LAUNCHER_SOURCE="${SCRIPT_DIR}/crashplan.sh"
LAUNCHER_TARGET="${LAUNCHER_PATH}"

mkdir --parents "$(dirname "${LAUNCHER_TARGET}")"

ln --symbolic --force "${LAUNCHER_SOURCE}" "${LAUNCHER_TARGET}"

echo "Symlink updated:"
echo "  ${LAUNCHER_TARGET} -> ${LAUNCHER_SOURCE}"
