#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
APPS_DIR="${USER_HOME}/Buildiful/apps"

echo "Installed app packs"
echo

if [[ ! -d "${APPS_DIR}" ]]; then
  echo "Apps directory not found: ${APPS_DIR}"
  exit 0
fi

mapfile -t PACK_DIRS < <(find "${APPS_DIR}" -mindepth 1 -maxdepth 1 -type d | sort)

if [[ "${#PACK_DIRS[@]}" -eq 0 ]]; then
  echo "No app packs installed."
  exit 0
fi

for pack_dir in "${PACK_DIRS[@]}"; do
  manifest_file="${pack_dir}/manifest.env"
  pack_slug="$(basename "${pack_dir}")"

  echo "Pack: ${pack_slug}"

  if [[ -f "${manifest_file}" ]]; then
    unset BUILDIFUL_PACK_NAME BUILDIFUL_PACK_SLUG BUILDIFUL_PACK_VERSION BUILDIFUL_PACK_DESCRIPTION BUILDIFUL_PACK_STATUS BUILDIFUL_PACK_ENTRYPOINT BUILDIFUL_PACK_DOCS_PATH || true
    # shellcheck disable=SC1090
    source "${manifest_file}"

    echo "  Name: ${BUILDIFUL_PACK_NAME:-unknown}"
    echo "  Slug: ${BUILDIFUL_PACK_SLUG:-${pack_slug}}"
    echo "  Version: ${BUILDIFUL_PACK_VERSION:-unknown}"
    echo "  Status: ${BUILDIFUL_PACK_STATUS:-unknown}"
    echo "  Description: ${BUILDIFUL_PACK_DESCRIPTION:-none}"
  else
    echo "  Manifest: missing"
  fi

  echo
done