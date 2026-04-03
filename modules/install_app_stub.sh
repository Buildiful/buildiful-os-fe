#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/../config/release.env"

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
APP_DIR="${USER_HOME}/Buildiful/apps/stock-trading-agent"
APP_FILE="${APP_DIR}/README.txt"

mkdir -p "${APP_DIR}"
sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${APP_DIR}"

cat > "${APP_FILE}" <<EOP
Stock Trading Agent
Provided by ${BUILDIFUL_OS_NAME}
Version: ${BUILDIFUL_OS_VERSION}

This is a placeholder for the stock trading agent application bundle.
EOP

echo "Installed app stub to: ${APP_DIR}"
find "${APP_DIR}" -maxdepth 2 | sort
echo
cat "${APP_FILE}"
