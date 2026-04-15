#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_TEMPLATES_DIR="${REPO_ROOT}/config/templates"
TARGET_TEMPLATES_DIR="${USER_HOME}/Buildiful/config/templates"

if [[ ! -d "${SOURCE_TEMPLATES_DIR}" ]]; then
  echo "ERROR: Config templates directory not found: ${SOURCE_TEMPLATES_DIR}"
  exit 1
fi

mkdir -p "${TARGET_TEMPLATES_DIR}"
cp -R "${SOURCE_TEMPLATES_DIR}/." "${TARGET_TEMPLATES_DIR}/"

sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${TARGET_TEMPLATES_DIR}"

echo "Installed config templates to: ${TARGET_TEMPLATES_DIR}"
find "${TARGET_TEMPLATES_DIR}" -maxdepth 2 -type f | sort