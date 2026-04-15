#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BRANDING_SOURCE_DIR="${REPO_ROOT}/branding"
BRANDING_TARGET_DIR="${USER_HOME}/Buildiful/branding"

mkdir -p "${BRANDING_TARGET_DIR}"

cp "${BRANDING_SOURCE_DIR}/buildiful-os-fe-release.txt" "${BRANDING_TARGET_DIR}/"
cp "${BRANDING_SOURCE_DIR}/buildiful-os-fe-logo.txt" "${BRANDING_TARGET_DIR}/"

sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${BRANDING_TARGET_DIR}"

echo "Installed branding files to: ${BRANDING_TARGET_DIR}"
find "${BRANDING_TARGET_DIR}" -maxdepth 2 -type f | sort
echo
cat "${BRANDING_TARGET_DIR}/buildiful-os-fe-release.txt"
echo
echo
cat "${BRANDING_TARGET_DIR}/buildiful-os-fe-logo.txt"
echo