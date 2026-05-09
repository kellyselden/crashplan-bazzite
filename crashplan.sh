#!/usr/bin/env bash

set -e

# ------------------------------------------------------------
# Resolve the real path of this script (follows symlinks)
# ------------------------------------------------------------
SOURCE="${BASH_SOURCE[0]}"

while [ -h "$SOURCE" ]; do
  DIR="$(cd -P -- "$(dirname -- "$SOURCE")" && pwd)"
  SOURCE="$(readlink -- "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="${DIR}/${SOURCE}"
done

SCRIPT_DIR="$(cd -P -- "$(dirname -- "$SOURCE")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

echo "[crashplan] Ensuring service is running"

run_in_container '
set -e

LOG_FILE="/tmp/crashplan-startup.log"
mkdir -p "$(dirname "$LOG_FILE")"

echo "[crashplan] before service" >> "$LOG_FILE"

sudo /usr/local/crashplan/bin/service.sh start >> "$LOG_FILE" 2>&1 || true

echo "[crashplan] after service" >> "$LOG_FILE"
'

echo "[crashplan] Launching GUI"

distrobox enter \
  --name crashplan \
  -- \
  bash --login -c "
    /usr/local/crashplan/bin/desktop.sh
  " &
