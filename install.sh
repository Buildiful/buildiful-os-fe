#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/config/release.env"

echo "Starting ${BUILDIFUL_OS_NAME} installer..."
echo "Project: ${BUILDIFUL_OS_SLUG}"
echo "Base: ${BUILDIFUL_OS_BASE}"
echo "Version: ${BUILDIFUL_OS_VERSION}"
echo "Channel: ${BUILDIFUL_OS_CHANNEL}"
echo

./bin/check_system.sh
echo
./bin/check_user.sh
echo
./modules/check_dependencies.sh
echo
./modules/install_core_packages.sh
echo
./modules/install_cli_baseline.sh
echo
./modules/install_github_cli.sh
echo
./modules/install_python_tooling.sh
echo
./modules/create_user_dirs.sh
echo
./modules/write_machine_profile.sh
echo
./modules/init_log.sh
echo
./modules/install_branding_stub.sh
echo
./modules/install_app_stub.sh
echo
./modules/write_install_state.sh
