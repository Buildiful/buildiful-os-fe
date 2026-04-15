#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
RELEASE_ENV="${INSTALL_ROOT}/config/release.env"

# shellcheck disable=SC1090
source "${RELEASE_ENV}"

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BUILDIFUL_HOME="${USER_HOME}/Buildiful"
INSTALL_STATE_FILE="${BUILDIFUL_HOME}/config/install-state.env"
MACHINE_PROFILE_FILE="${BUILDIFUL_HOME}/config/machine-profile.env"

print_dir_status() {
  local label="$1"
  local path="$2"

  if [[ -d "$path" ]]; then
    printf "  %-10s OK\n" "$label"
  else
    printf "  %-10s MISSING\n" "$label"
  fi
}

print_tool_status() {
  local label="$1"
  local command_name="$2"

  if command -v "$command_name" >/dev/null 2>&1; then
    printf "  %-10s OK\n" "$label"
  else
    printf "  %-10s MISSING\n" "$label"
  fi
}

echo "${BUILDIFUL_OS_NAME}"
echo "Version: ${BUILDIFUL_OS_VERSION}"
echo "Channel: ${BUILDIFUL_OS_CHANNEL}"
echo "Base: ${BUILDIFUL_OS_BASE}"
echo

echo "Machine: $(hostname)"
echo "User: ${CURRENT_USER}"
echo "Home: ${USER_HOME}"
echo

echo "State files:"
if [[ -f "${INSTALL_STATE_FILE}" ]]; then
  echo "  install-state  OK"
else
  echo "  install-state  MISSING"
fi

if [[ -f "${MACHINE_PROFILE_FILE}" ]]; then
  echo "  machine-profile OK"
else
  echo "  machine-profile MISSING"
fi
echo

echo "Core directories:"
print_dir_status "apps"      "${BUILDIFUL_HOME}/apps"
print_dir_status "agents"    "${BUILDIFUL_HOME}/agents"
print_dir_status "config"    "${BUILDIFUL_HOME}/config"
print_dir_status "data"      "${BUILDIFUL_HOME}/data"
print_dir_status "docs"      "${BUILDIFUL_HOME}/docs"
print_dir_status "logs"      "${BUILDIFUL_HOME}/logs"
print_dir_status "backups"   "${BUILDIFUL_HOME}/backups"
print_dir_status "scripts"   "${BUILDIFUL_HOME}/scripts"
print_dir_status "models"    "${BUILDIFUL_HOME}/models"
print_dir_status "inbox"     "${BUILDIFUL_HOME}/inbox"
print_dir_status "exports"   "${BUILDIFUL_HOME}/exports"
print_dir_status "branding"  "${BUILDIFUL_HOME}/branding"
echo

echo "Tooling:"
print_tool_status "python3" "python3"
print_tool_status "pip3"    "pip3"
print_tool_status "node"    "node"
print_tool_status "npm"     "npm"
print_tool_status "sqlite3" "sqlite3"
print_tool_status "tmux"    "tmux"
print_tool_status "cron"    "cron"
print_tool_status "gh"      "gh"
echo

echo "Installed packs:"
if [[ -d "${BUILDIFUL_HOME}/apps" ]]; then
  mapfile -t PACK_DIRS < <(find "${BUILDIFUL_HOME}/apps" -mindepth 1 -maxdepth 1 -type d | sort)
  if [[ "${#PACK_DIRS[@]}" -eq 0 ]]; then
    echo "  none"
  else
    for pack_dir in "${PACK_DIRS[@]}"; do
      echo "  $(basename "$pack_dir")"
    done
  fi
else
  echo "  apps directory missing"
fi