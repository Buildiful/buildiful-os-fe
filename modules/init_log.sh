#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/../config/release.env"

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
LOG_DIR="${USER_HOME}/Buildiful/logs"
LOG_FILE="${LOG_DIR}/install.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
HOSTNAME_VALUE="$(hostname)"

mkdir -p "${LOG_DIR}"
sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${LOG_DIR}"

cat >> "${LOG_FILE}" <<EOP
[${TIMESTAMP}] buildiful-os-fe install run started
  os_name=${BUILDIFUL_OS_NAME}
  os_slug=${BUILDIFUL_OS_SLUG}
  os_version=${BUILDIFUL_OS_VERSION}
  os_channel=${BUILDIFUL_OS_CHANNEL}
  hostname=${HOSTNAME_VALUE}
  user=${CURRENT_USER}
EOP

echo "Initialized install log at: ${LOG_FILE}"
tail -n 7 "${LOG_FILE}"
