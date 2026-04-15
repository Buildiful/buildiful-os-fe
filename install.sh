#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/config/release.env"

echo "Starting ${BUILDIFUL_OS_NAME} installer..."
echo "Project: ${BUILDIFUL_OS_SLUG}"
echo "Base: ${BUILDIFUL_OS_BASE}"
echo "Version: ${BUILDIFUL_OS_VERSION}"
echo "Channel: ${BUILDIFUL_OS_CHANNEL}"
echo

bash ./bin/check_system.sh
echo
bash ./bin/check_user.sh
echo
bash ./modules/check_dependencies.sh
echo
bash ./modules/install_core_packages.sh
echo
bash ./modules/install_cli_baseline.sh
echo
bash ./modules/install_github_cli.sh
echo
bash ./modules/install_python_tooling.sh
echo
bash ./modules/install_nodejs.sh
echo
bash ./modules/install_sqlite.sh
echo
bash ./modules/install_tmux.sh
echo
bash ./modules/install_cron.sh
echo
bash ./modules/create_user_dirs.sh
echo
bash ./modules/write_machine_profile.sh
echo
bash ./modules/init_log.sh
echo
bash ./modules/install_branding_stub.sh
echo
bash ./modules/install_cli.sh
echo
bash ./modules/write_install_state.sh
echo
echo "Install complete."
echo "Next steps:"
echo "  bos version"
echo "  bos status"
echo "  bos doctor"