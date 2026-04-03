#!/usr/bin/env bash
set -euo pipefail

PACKAGES_TO_ENSURE=("curl" "git")
MISSING_PACKAGES=()

for pkg in "${PACKAGES_TO_ENSURE[@]}"; do
  if dpkg -s "$pkg" >/dev/null 2>&1; then
    echo "Package already installed: $pkg"
  else
    echo "Package missing: $pkg"
    MISSING_PACKAGES+=("$pkg")
  fi
done

if [[ ${#MISSING_PACKAGES[@]} -eq 0 ]]; then
  echo "No package installation needed."
  exit 0
fi

echo "Installing missing packages: ${MISSING_PACKAGES[*]}"
sudo apt-get update
sudo apt-get install -y "${MISSING_PACKAGES[@]}"
echo "Core package installation complete."
