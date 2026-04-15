#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_ROOT="/usr/local/lib/buildiful-os-fe"
TARGET_BIN_DIR="${INSTALL_ROOT}/bin"
TARGET_CONFIG_DIR="${INSTALL_ROOT}/config"
TARGET_COMMAND="/usr/local/bin/bos"

sudo mkdir -p "${TARGET_BIN_DIR}"
sudo mkdir -p "${TARGET_CONFIG_DIR}"

sudo cp "${REPO_ROOT}/bin/"* "${TARGET_BIN_DIR}/"
sudo cp "${REPO_ROOT}/config/release.env" "${TARGET_CONFIG_DIR}/release.env"

sudo chmod +x "${TARGET_BIN_DIR}/bos"
sudo chmod +x "${TARGET_BIN_DIR}/bos-version.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-status.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-doctor.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-dirs.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-apps.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-docs.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-backup.sh"
sudo chmod +x "${TARGET_BIN_DIR}/bos-launch.sh"

sudo tee "${TARGET_COMMAND}" >/dev/null <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
exec /usr/local/lib/buildiful-os-fe/bin/bos "$@"
EOF

sudo chmod +x "${TARGET_COMMAND}"

echo "Installed BOS CLI files to: ${TARGET_BIN_DIR}"
echo "Installed BOS release metadata to: ${TARGET_CONFIG_DIR}/release.env"
echo "Installed bos command to: ${TARGET_COMMAND}"