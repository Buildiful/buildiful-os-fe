#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  cron
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
  echo "Installing cron packages: ${MISSING[*]}"
  sudo apt-get install -y -qq "${MISSING[@]}" >/dev/null
else
  echo "No cron packages needed."
fi

sudo systemctl enable cron >/dev/null 2>&1 || true
sudo systemctl start cron >/dev/null 2>&1 || true

echo "cron installed and service start attempted"
