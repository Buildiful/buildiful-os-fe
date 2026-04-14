#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# shellcheck disable=SC1091
source "${REPO_ROOT}/config/release.env"

echo "${BUILDIFUL_OS_NAME}"
echo "Version: ${BUILDIFUL_OS_VERSION}"
echo "Channel: ${BUILDIFUL_OS_CHANNEL}"
echo "Base: ${BUILDIFUL_OS_BASE}"