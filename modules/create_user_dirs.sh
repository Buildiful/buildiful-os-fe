#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BUILDIFUL_HOME="${USER_HOME}/Buildiful"

DIRECTORIES=(
  "${BUILDIFUL_HOME}"
  "${BUILDIFUL_HOME}/apps"
  "${BUILDIFUL_HOME}/agents"
  "${BUILDIFUL_HOME}/config"
  "${BUILDIFUL_HOME}/data"
  "${BUILDIFUL_HOME}/docs"
  "${BUILDIFUL_HOME}/logs"
  "${BUILDIFUL_HOME}/backups"
  "${BUILDIFUL_HOME}/scripts"
  "${BUILDIFUL_HOME}/models"
  "${BUILDIFUL_HOME}/inbox"
  "${BUILDIFUL_HOME}/exports"
  "${BUILDIFUL_HOME}/branding"
)

for dir in "${DIRECTORIES[@]}"; do
  mkdir -p "$dir"
done

sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${BUILDIFUL_HOME}"

echo "Created user directories under: ${BUILDIFUL_HOME}"
find "${BUILDIFUL_HOME}" -maxdepth 2 | sort