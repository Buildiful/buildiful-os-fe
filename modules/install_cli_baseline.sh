#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  jq
  unzip
  zip
  htop
  tree
)

sudo apt-get update -y

MISSING=()
for pkg in "${PACKAGES[@]}"; do
  if dpkg -s "$pkg" >/dev/null 2>&1; then
    echo "Package already installed: $pkg"
  else
    MISSING+=("$pkg")
  fi
done

if [ "${#MISSING[@]}" -gt 0 ]; then
  echo "Installing CLI baseline packages: ${MISSING[*]}"
  sudo apt-get install -y "${MISSING[@]}"
else
  echo "No CLI baseline packages needed."
fi
