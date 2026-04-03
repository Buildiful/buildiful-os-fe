#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  sqlite3
)

sudo apt-get update -y >/dev/null

MISSING=()
for pkg in "${PACKAGES[@]}"; do
  if dpkg -s "$pkg" >/dev/null 2>&1; then
    echo "Package already installed: $pkg"
  else
    MISSING+=("$pkg")
  fi
done

if [ "${#MISSING[@]}" -gt 0 ]; then
  echo "Installing SQLite packages: ${MISSING[*]}"
  sudo apt-get install -y -qq "${MISSING[@]}" >/dev/null
else
  echo "No SQLite packages needed."
fi

echo "SQLite version: $(sqlite3 --version | awk '{print $1}')"
