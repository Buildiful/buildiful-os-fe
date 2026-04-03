#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"

if [[ -z "${CURRENT_USER}" ]]; then
  echo "ERROR: Could not determine current user."
  exit 1
fi

if [[ -z "${USER_HOME}" ]]; then
  echo "ERROR: Could not determine home directory for user: ${CURRENT_USER}"
  exit 1
fi

echo "Detected user: ${CURRENT_USER}"
echo "User home: ${USER_HOME}"
