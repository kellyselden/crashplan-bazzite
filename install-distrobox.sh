#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

echo "==> Creating container: ${CONTAINER_NAME}"

distrobox create \
  --name "${CONTAINER_NAME}" \
  --image "${IMAGE}" \
  --yes || true

# ------------------------------------------------------------
# Everything happens inside container now
# ------------------------------------------------------------
run_in_container "
set -e

echo '===================================================='
echo 'CrashPlan install starting (fully container-managed)'
echo '===================================================='

# --------------------------------------------------------
# Container-owned workspace + cleanup
# --------------------------------------------------------
WORKDIR=\$(mktemp --directory --tmpdir=/var/tmp crashplan.XXXXXX)
ARCHIVE=\$WORKDIR/crashplan.tgz
EXTRACT_DIR=\$WORKDIR/extract

echo \"WORKDIR: \$WORKDIR\"

cleanup() {
  echo '==> Cleaning up container workspace'
  rm -rf \"\$WORKDIR\"
}
trap cleanup EXIT

# --------------------------------------------------------
# Dependencies
# --------------------------------------------------------
sudo apt-get update

sudo apt-get install --yes \
  libxss1 \
  net-tools \
  libnss3 \
  libnsl2 \
  openjdk-17-jre \

# --------------------------------------------------------
# Download
# --------------------------------------------------------
echo '==> Downloading installer'
wget --output-document \"\$ARCHIVE\" \"${INSTALL_URL}\"

# --------------------------------------------------------
# Extract
# --------------------------------------------------------
echo '==> Extracting installer'
mkdir -p \"\$EXTRACT_DIR\"

tar \
  --extract \
  --verbose \
  --gzip \
  --file \"\$ARCHIVE\" \
  --directory \"\$EXTRACT_DIR\"

INSTALL_DIR=\$(find \"\$EXTRACT_DIR\" -maxdepth 2 -type d -name 'crashplan*' | head -n 1)

echo \"INSTALL_DIR: \$INSTALL_DIR\"

cd \"\$INSTALL_DIR\"

# --------------------------------------------------------
# Install
# --------------------------------------------------------
echo '==> Running installer'
sudo ./install.sh

echo '===================================================='
echo 'Install complete'
echo '===================================================='
"
