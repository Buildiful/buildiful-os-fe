#!/usr/bin/env bash
set -euo pipefail

CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(getent passwd "$CURRENT_USER" | cut -d: -f6)"
BUILDIFUL_HOME="${USER_HOME}/Buildiful"

print_dir_line() {
  local name="$1"
  local description="$2"
  local path="${BUILDIFUL_HOME}/${name}"

  if [[ -d "$path" ]]; then
    printf "%-10s %-40s %s\n" "$name" "present" "$description"
  else
    printf "%-10s %-40s %s\n" "$name" "missing" "$description"
  fi
}

echo "Buildiful workspace"
echo "Root: ${BUILDIFUL_HOME}"
echo

printf "%-10s %-40s %s\n" "Folder" "Status" "Purpose"
printf "%-10s %-40s %s\n" "------" "------" "-------"

print_dir_line "apps"     "Installed app packs and local app bundles"
print_dir_line "agents"   "Runtime working files for agents"
print_dir_line "config"   "BOS config, templates, machine profile, install state"
print_dir_line "data"     "Structured local-first data"
print_dir_line "docs"     "Local BOS docs and examples"
print_dir_line "logs"     "Install and runtime logs"
print_dir_line "backups"  "Generated backup archives"
print_dir_line "scripts"  "User-visible helper scripts"
print_dir_line "models"   "Local model storage or references"
print_dir_line "inbox"    "Drop zone for files to be processed"
print_dir_line "exports"  "Reports and generated outputs"
print_dir_line "branding" "Release notes and local branding assets"