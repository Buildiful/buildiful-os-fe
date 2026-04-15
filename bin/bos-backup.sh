#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BUILDIFUL_HOME="${USER_HOME}/Buildiful"
BACKUPS_DIR="${BUILDIFUL_HOME}/backups"
TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"
ARCHIVE_PATH="${BACKUPS_DIR}/buildiful-backup-${TIMESTAMP}.tar.gz"

if [[ ! -d "${BUILDIFUL_HOME}" ]]; then
  echo "ERROR: Buildiful workspace not found: ${BUILDIFUL_HOME}"
  exit 1
fi

mkdir -p "${BACKUPS_DIR}"

INCLUDE_PATHS=()

for path in \
  "${BUILDIFUL_HOME}/config" \
  "${BUILDIFUL_HOME}/data" \
  "${BUILDIFUL_HOME}/logs" \
  "${BUILDIFUL_HOME}/apps"
do
  if [[ -e "${path}" ]]; then
    INCLUDE_PATHS+=("${path}")
  fi
done

if [[ "${#INCLUDE_PATHS[@]}" -eq 0 ]]; then
  echo "ERROR: Nothing to back up yet."
  exit 1
fi

tar -czf "${ARCHIVE_PATH}" "${INCLUDE_PATHS[@]}"

echo "Backup created:"
echo "  ${ARCHIVE_PATH}"