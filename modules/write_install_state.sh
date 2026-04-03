#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/../config/release.env"

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
STATE_DIR="${USER_HOME}/Buildiful/config"
STATE_FILE="${STATE_DIR}/install-state.env"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

mkdir -p "${STATE_DIR}"
sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${STATE_DIR}"

cat > "${STATE_FILE}" <<EOP
BUILDIFUL_OS_INSTALLED="true"
BUILDIFUL_OS_NAME="${BUILDIFUL_OS_NAME}"
BUILDIFUL_OS_SLUG="${BUILDIFUL_OS_SLUG}"
BUILDIFUL_OS_VERSION="${BUILDIFUL_OS_VERSION}"
BUILDIFUL_OS_CHANNEL="${BUILDIFUL_OS_CHANNEL}"
BUILDIFUL_OS_INSTALLED_AT="${TIMESTAMP}"
EOP

echo "Wrote install state to: ${STATE_FILE}"
cat "${STATE_FILE}"
