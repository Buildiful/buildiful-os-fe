#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  python3-pip
  python3-venv
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
  echo "Installing Python tooling packages: ${MISSING[*]}"
  sudo apt-get install -y "${MISSING[@]}"
else
  echo "No Python tooling packages needed."
fi

python3 --version
pip3 --version
