#!/usr/bin/env bash

set -e

AUTOSTART_DIR="${HOME}/.config/autostart"
DESKTOP_FILE="${AUTOSTART_DIR}/crashplan.desktop"

mkdir --parents "${AUTOSTART_DIR}"

cat > "${DESKTOP_FILE}" <<EOF
# Managed by setup scripts — do not edit manually
[Desktop Entry]
Type=Application
Name=CrashPlan
Exec=${HOME}/.local/bin/crashplan
X-GNOME-Autostart-enabled=true
NoDisplay=false
EOF

echo "Autostart entry written:"
echo "  ${DESKTOP_FILE}"
