#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
RELEASE_ENV="${INSTALL_ROOT}/config/release.env"

# shellcheck disable=SC1090
source "${RELEASE_ENV}"

echo "${BUILDIFUL_OS_NAME}"
echo "Version: ${BUILDIFUL_OS_VERSION}"
echo "Channel: ${BUILDIFUL_OS_CHANNEL}"
echo "Base: ${BUILDIFUL_OS_BASE}"