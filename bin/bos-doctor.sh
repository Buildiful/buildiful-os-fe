#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BUILDIFUL_HOME="${USER_HOME}/Buildiful"

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() {
  echo "PASS  $1"
  PASS_COUNT=$((PASS_COUNT + 1))
}

warn() {
  echo "WARN  $1"
  WARN_COUNT=$((WARN_COUNT + 1))
}

fail() {
  echo "FAIL  $1"
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

check_dir() {
  local path="$1"
  local label="$2"

  if [[ -d "$path" ]]; then
    pass "${label} directory present"
  else
    warn "${label} directory missing"
  fi
}

check_file() {
  local path="$1"
  local label="$2"

  if [[ -f "$path" ]]; then
    pass "${label} found"
  else
    warn "${label} missing"
  fi
}

check_cmd() {
  local cmd="$1"
  local label="$2"
  local severity="${3:-warn}"

  if command -v "$cmd" >/dev/null 2>&1; then
    pass "${label} available"
  else
    if [[ "$severity" == "fail" ]]; then
      fail "${label} missing"
    else
      warn "${label} missing"
    fi
  fi
}

echo "Doctor report"
echo

if [[ -f /etc/os-release ]]; then
  # shellcheck disable=SC1091
  source /etc/os-release
  if [[ "${ID:-}" == "ubuntu" && "${VERSION_ID:-}" == "24.04" ]]; then
    pass "Ubuntu 24.04 detected"
  else
    fail "Expected Ubuntu 24.04, found ${PRETTY_NAME:-unknown}"
  fi
else
  fail "/etc/os-release not found"
fi

check_file "${BUILDIFUL_HOME}/config/install-state.env" "Install state"
check_file "${BUILDIFUL_HOME}/config/machine-profile.env" "Machine profile"

check_dir "${BUILDIFUL_HOME}/apps" "apps"
check_dir "${BUILDIFUL_HOME}/agents" "agents"
check_dir "${BUILDIFUL_HOME}/config" "config"
check_dir "${BUILDIFUL_HOME}/data" "data"
check_dir "${BUILDIFUL_HOME}/docs" "docs"
check_dir "${BUILDIFUL_HOME}/logs" "logs"
check_dir "${BUILDIFUL_HOME}/backups" "backups"
check_dir "${BUILDIFUL_HOME}/scripts" "scripts"
check_dir "${BUILDIFUL_HOME}/models" "models"
check_dir "${BUILDIFUL_HOME}/inbox" "inbox"
check_dir "${BUILDIFUL_HOME}/exports" "exports"
check_dir "${BUILDIFUL_HOME}/branding" "branding"

echo

check_cmd "python3" "python3" fail
check_cmd "node" "node"
check_cmd "npm" "npm"
check_cmd "pip3" "pip3"
check_cmd "sqlite3" "sqlite3"
check_cmd "tmux" "tmux"
check_cmd "cron" "cron"
check_cmd "gh" "GitHub CLI"

echo

if [[ -d "${BUILDIFUL_HOME}/backups" && -w "${BUILDIFUL_HOME}/backups" ]]; then
  pass "Backup directory writable"
else
  warn "Backup directory not writable or missing"
fi

if [[ -d "${BUILDIFUL_HOME}/apps" ]]; then
  mapfile -t PACK_MANIFESTS < <(find "${BUILDIFUL_HOME}/apps" -mindepth 2 -maxdepth 2 -name manifest.env | sort)
  if [[ "${#PACK_MANIFESTS[@]}" -gt 0 ]]; then
    pass "Pack manifests found"
  else
    warn "No pack manifests found yet"
  fi
else
  warn "Apps directory missing, pack scan skipped"
fi

echo
echo "Summary:"
echo "  PASS  ${PASS_COUNT}"
echo "  WARN  ${WARN_COUNT}"
echo "  FAIL  ${FAIL_COUNT}"
echo

if [[ "${FAIL_COUNT}" -gt 0 ]]; then
  echo "Result: unhealthy"
  exit 1
elif [[ "${WARN_COUNT}" -gt 0 ]]; then
  echo "Result: healthy with warnings"
else
  echo "Result: healthy"
fi