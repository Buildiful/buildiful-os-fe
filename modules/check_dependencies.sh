#!/usr/bin/env bash
set -euo pipefail

REQUIRED_BINS=("curl" "git")

for bin in "${REQUIRED_BINS[@]}"; do
  if command -v "$bin" >/dev/null 2>&1; then
    echo "Found dependency: $bin"
  else
    echo "ERROR: Missing dependency: $bin"
    exit 1
  fi
done

echo "Dependency check passed."
