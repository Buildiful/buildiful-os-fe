#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f /etc/os-release ]]; then
  echo "ERROR: /etc/os-release not found."
  exit 1
fi

. /etc/os-release

echo "Detected OS: ${PRETTY_NAME:-unknown}"

if [[ "${ID:-}" != "ubuntu" ]]; then
  echo "ERROR: This installer currently supports Ubuntu only."
  exit 1
fi

if [[ "${VERSION_ID:-}" != "24.04" ]]; then
  echo "ERROR: This installer currently targets Ubuntu 24.04."
  exit 1
fi

echo "System check passed."
