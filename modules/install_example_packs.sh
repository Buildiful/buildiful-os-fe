#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_PACKS_DIR="${REPO_ROOT}/packs/examples"
TARGET_APPS_DIR="${USER_HOME}/Buildiful/apps"

if [[ ! -d "${SOURCE_PACKS_DIR}" ]]; then
  echo "ERROR: Example packs directory not found: ${SOURCE_PACKS_DIR}"
  exit 1
fi

mkdir -p "${TARGET_APPS_DIR}"
cp -R "${SOURCE_PACKS_DIR}/." "${TARGET_APPS_DIR}/"

sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${TARGET_APPS_DIR}"

echo "Installed example packs to: ${TARGET_APPS_DIR}"
find "${TARGET_APPS_DIR}" -maxdepth 2 -type f | sort