#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DOCS_DIR="${REPO_ROOT}/docs"
TARGET_DOCS_DIR="${USER_HOME}/Buildiful/docs"

if [[ ! -d "${SOURCE_DOCS_DIR}" ]]; then
  echo "ERROR: Repo docs directory not found: ${SOURCE_DOCS_DIR}"
  exit 1
fi

mkdir -p "${TARGET_DOCS_DIR}"
cp -R "${SOURCE_DOCS_DIR}/." "${TARGET_DOCS_DIR}/"

sudo chown -R "${CURRENT_USER}:${CURRENT_USER}" "${TARGET_DOCS_DIR}"

echo "Installed docs to: ${TARGET_DOCS_DIR}"
find "${TARGET_DOCS_DIR}" -maxdepth 2 -type f | sort