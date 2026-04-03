#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BRANDING_DIR="${USER_HOME}/Buildiful/branding"

mkdir -p "${BRANDING_DIR}"
cp "$(dirname "$0")/../branding/buildiful-os-fe-release.txt" "${BRANDING_DIR}/"

echo "Installed branding stub to: ${BRANDING_DIR}"
find "${BRANDING_DIR}" -maxdepth 2 | sort
echo
cat "${BRANDING_DIR}/buildiful-os-fe-release.txt"
