# NetLens Pacman & Shelly Repository

Official Pacman and Shelly repository for **CachyOS** and **Arch Linux** (`x86_64` architecture).

---

## ⚡ Quick 1-Command Installation

Copy and paste this command in your terminal (compatible with Fish, Bash, and Zsh):
```bash
curl -sSL https://omarmurcia.github.io/netlens-repo/install-repo.sh | bash
```

---

## 🚀 Manual Installation Guide

### 1. Add Repository to Pacman
Open `/etc/pacman.conf` with root permissions:
```bash
sudo nano /etc/pacman.conf
```

Append the following block to the end of the file:
```ini
[netlens]
SigLevel = Optional TrustAll
Server = https://omarmurcia.github.io/netlens-repo/$arch
```

### 2. Synchronize and Install with Shelly (CachyOS)
```bash
shelly sync
shelly install standard netlens
```
Or open the graphical **Shelly** application, search for `netlens`, and click **Install**.

### 3. Or Install with Pacman (Arch Linux / CachyOS)
```bash
sudo pacman -Sy --noconfirm netlens
```

---

## 🪟 Windows Installation

NetLens also runs natively on **Windows 10/11 (x86_64)**. In PowerShell:
```powershell
irm https://omarmurcia.github.io/netlens-repo/install-windows.ps1 | iex
```
The script downloads the latest `netlens-*-windows-x86_64.zip` from the [NetLens releases](https://github.com/omarmurcia/netlens/releases), installs it in `%LOCALAPPDATA%\NetLens` and creates a Start Menu shortcut. Re-run it to update.

---
## 📦 Automatic Updates
When a new version is released, Shelly and Pacman will automatically detect it:
```bash
shelly upgrade
# or
sudo pacman -Syu
```

---

## 🛠️ Repository Layout
```
netlens-repo/
├── index.html                  # GitHub Pages landing page
├── install-repo.sh             # 1-command curl installer script (Arch / CachyOS)
├── install-windows.ps1         # 1-command PowerShell installer (Windows)
├── assets/                     # Icons and visual brand assets
└── x86_64/
    ├── netlens-0.1.0-1-x86_64.pkg.tar.zst
    ├── netlens.db
    ├── netlens.db.tar.zst
    ├── netlens.files
    └── netlens.files.tar.zst
```
