#!/usr/bin/env bash
set -euo pipefail

if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  echo "Node.js already installed: $(node --version)"
  echo "npm already installed: $(npm --version)"
  exit 0
fi

NODE_MAJOR=22

echo "Installing Node.js ${NODE_MAJOR} (minimal setup)..."

curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | sudo -E bash - >/dev/null 2>&1
sudo apt-get install -y -qq nodejs >/dev/null

echo "Installed Node.js: $(node --version)"
echo "Installed npm: $(npm --version)"
