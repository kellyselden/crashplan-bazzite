#!/usr/bin/env bash

# ------------------------------------------------------------
# Shared configuration
# ------------------------------------------------------------

CONTAINER_NAME="crashplan"
IMAGE="ubuntu:24.04"

INSTALL_URL="https://console.us2.crashplan.com/api/v3/download/agent/linux"

# Host paths
LAUNCHER_PATH="${HOME}/.local/bin/crashplan"
DESKTOP_PATH="${HOME}/.config/autostart/crashplan.desktop"

# Container install path
CRASHPLAN_INSTALL_DIR="/usr/local/crashplan"

# ------------------------------------------------------------
# Run a command inside the CrashPlan Distrobox container
# ------------------------------------------------------------
run_in_container() {
  local cmd="$1"

  distrobox enter \
    --name "${CONTAINER_NAME}" \
    -- \
    bash --login -c "${cmd}"
}
