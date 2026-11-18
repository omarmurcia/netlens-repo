#!/usr/bin/env bash
set -e

# Script de instalación automática del repositorio NetLens para CachyOS / Arch Linux
GITHUB_USER="${1:-omarmurcia}"
REPO_URL="https://${GITHUB_USER}.github.io/netlens-repo/\$arch"

echo "=========================================================="
echo "⚡ Instalador Oficial de NetLens (CachyOS / Arch Linux)"
echo "=========================================================="

if grep -q "\[netlens\]" /etc/pacman.conf; then
    echo "ℹ️ El repositorio [netlens] ya está configurado en /etc/pacman.conf"
else
    echo "==> Agregando repositorio [netlens] a /etc/pacman.conf..."
    cat << EOF | sudo tee -a /etc/pacman.conf

[netlens]
SigLevel = Optional TrustAll
Server = ${REPO_URL}
EOF
    echo "✅ Repositorio agregado correctamente."
fi

echo "==> Sincronizando repositorio e instalando NetLens..."
sudo pacman -Sy --noconfirm netlens

echo ""
echo "🎉 ¡NetLens ha sido instalado con éxito!"
echo "Puedes abrirlo desde tu menú de inicio (Internet) o ejecutando: netlens"
