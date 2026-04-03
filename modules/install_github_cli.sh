#!/usr/bin/env bash
set -euo pipefail

if command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI already installed: $(gh --version | head -n 1)"
  exit 0
fi

sudo mkdir -p /etc/apt/keyrings

if [ ! -f /etc/apt/keyrings/githubcli-archive-keyring.gpg ]; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/etc/apt/keyrings/githubcli-archive-keyring.gpg
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
fi

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt-get update -y
sudo apt-get install -y gh

echo "Installed GitHub CLI: $(gh --version | head -n 1)"
