#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  tmux
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
  echo "Installing tmux packages: ${MISSING[*]}"
  sudo apt-get install -y -qq "${MISSING[@]}" >/dev/null
else
  echo "No tmux packages needed."
fi

echo "tmux version: $(tmux -V)"
