#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"

mkdir -p "${USER_HOME}/Buildiful"
mkdir -p "${USER_HOME}/Buildiful/apps"
mkdir -p "${USER_HOME}/Buildiful/config"
mkdir -p "${USER_HOME}/Buildiful/logs"
mkdir -p "${USER_HOME}/Buildiful/data"

echo "Created user directories under: ${USER_HOME}/Buildiful"
find "${USER_HOME}/Buildiful" -maxdepth 2 | sort
