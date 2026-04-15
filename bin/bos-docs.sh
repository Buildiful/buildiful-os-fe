#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
DOCS_DIR="${USER_HOME}/Buildiful/docs"
DOCS_INDEX_HTML="${DOCS_DIR}/home/index.html"
GETTING_STARTED_MD="${DOCS_DIR}/getting-started.md"

echo "Buildiful OS docs"
echo "Docs directory: ${DOCS_DIR}"
echo

if [[ -f "${DOCS_INDEX_HTML}" ]]; then
  echo "Home screen: ${DOCS_INDEX_HTML}"
elif [[ -f "${GETTING_STARTED_MD}" ]]; then
  echo "Getting started: ${GETTING_STARTED_MD}"
else
  echo "No local docs installed yet."
fi