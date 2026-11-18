#!/usr/bin/env bash
set -e

# Script de instalación automática del repositorio NetLens para CachyOS / Arch Linux
GITHUB_USER="${1:-}"

if [ -z "${GITHUB_USER}" ]; then
    echo "=========================================================="
    echo "⚙️ Configuración del Repositorio NetLens para CachyOS/Arch"
    echo "=========================================================="
    read -rp "Ingresa tu usuario de GitHub (o presiona Enter si usas un dominio propio): " GITHUB_USER
fi

REPO_URL="https://${GITHUB_USER}.github.io/netlens-repo/\$arch"

if grep -q "\[netlens\]" /etc/pacman.conf; then
    echo "ℹ️ El repositorio [netlens] ya existe en /etc/pacman.conf"
else
    echo "==> Agregando repositorio [netlens] a /etc/pacman.conf..."
    cat << EOF | sudo tee -a /etc/pacman.conf

[netlens]
SigLevel = Optional TrustAll
Server = ${REPO_URL}
EOF
    echo "✅ Repositorio agregado correctamente."
fi

echo "==> Sincronizando bases de datos..."
if command -v shelly >/dev/null 2>&1; then
    shelly sync
    echo "==> Instalando NetLens con Shelly..."
    shelly install standard netlens
else
    sudo pacman -Sy --noconfirm netlens
fi

echo "🎉 ¡NetLens ha sido instalado con éxito!"
