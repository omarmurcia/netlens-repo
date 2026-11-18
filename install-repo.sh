#!/usr/bin/env bash
set -e

# Automated repository installation script for NetLens on CachyOS / Arch Linux
GITHUB_USER="${1:-omarmurcia}"
REPO_URL="https://${GITHUB_USER}.github.io/netlens-repo/\$arch"

echo "=========================================================="
echo "⚡ NetLens Official Installer & Updater (CachyOS / Arch)"
echo "=========================================================="

# 1. Terminate any running NetLens instances in background or system tray
if pgrep -x "netlens" >/dev/null 2>&1; then
    echo "==> Closing active NetLens background processes..."
    pkill -x "netlens" 2>/dev/null || true
    sleep 1
    if pgrep -x "netlens" >/dev/null 2>&1; then
        pkill -9 -x "netlens" 2>/dev/null || true
    fi
    echo "✅ Active NetLens processes closed."
fi

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

echo "==> Synchronizing repository and installing/updating NetLens..."
sudo rm -f /var/cache/pacman/pkg/netlens* 2>/dev/null || true
sudo pacman -Syy --noconfirm netlens

echo ""
echo "🎉 NetLens has been successfully installed/updated!"
echo "You can launch it from your application menu (Internet) or by running: netlens &"
