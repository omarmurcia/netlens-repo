#!/usr/bin/env bash
set -e

# Automated repository installation script for NetLens on CachyOS / Arch Linux
GITHUB_USER="${1:-omarmurcia}"
REPO_URL="https://${GITHUB_USER}.github.io/netlens-repo/\$arch"

echo "=========================================================="
echo "⚡ NetLens Official Installer (CachyOS / Arch Linux)"
echo "=========================================================="

if grep -q "\[netlens\]" /etc/pacman.conf; then
    echo "ℹ️ Repository [netlens] is already configured in /etc/pacman.conf"
else
    echo "==> Adding repository [netlens] to /etc/pacman.conf..."
    cat << EOF | sudo tee -a /etc/pacman.conf

[netlens]
SigLevel = Optional TrustAll
Server = ${REPO_URL}
EOF
    echo "✅ Repository added successfully."
fi

echo "==> Synchronizing repository and installing NetLens..."
sudo pacman -Sy --noconfirm netlens

echo ""
echo "🎉 NetLens has been successfully installed!"
echo "You can launch it from your application menu (Internet) or by running: netlens"
