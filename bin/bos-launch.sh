#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
DOCS_DIR="${USER_HOME}/Buildiful/docs"
DOCS_INDEX_HTML="${DOCS_DIR}/home/index.html"
GETTING_STARTED_MD="${DOCS_DIR}/getting-started.md"

open_with_system() {
  local target="$1"

  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$target" >/dev/null 2>&1 &
    echo "Opened: $target"
    exit 0
  fi

  echo "Open this file manually:"
  echo "  $target"
  exit 0
}

if [[ -f "${DOCS_INDEX_HTML}" ]]; then
  open_with_system "${DOCS_INDEX_HTML}"
elif [[ -f "${GETTING_STARTED_MD}" ]]; then
  open_with_system "${GETTING_STARTED_MD}"
else
  echo "No BOS home screen or local docs installed yet."
  echo "Expected docs directory:"
  echo "  ${DOCS_DIR}"
  exit 0
fi