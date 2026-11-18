# NetLens Pacman & Shelly Repository

Repositorio Pacman y Shelly oficial para **CachyOS** y **Arch Linux** (arquitectura `x86_64`).

---

## 🚀 Instalación en CachyOS con Shelly

### 1. Agregar el repositorio a Pacman
Edita `/etc/pacman.conf` (con permisos de superusuario):
```bash
sudo nano /etc/pacman.conf
```

Agrega al final:
```ini
[netlens]
SigLevel = Optional TrustAll
Server = https://<TU-USUARIO>.github.io/netlens-repo/$arch
```
*(Reemplaza `<TU-USUARIO>` por tu usuario de GitHub).*

### 2. Sincronizar e Instalar con Shelly
```bash
shelly sync
shelly install standard netlens
```
O simplemente abre la interfaz gráfica de **Shelly**, busca `netlens` y pulsa **Instalar**.

---

## 📦 Actualizaciones Automáticas
Cuando haya una nueva versión disponible, Shelly la detectará automáticamente:
```bash
shelly upgrade
```

---

## 🛠️ Estructura del Repositorio
```
netlens-repo/
├── index.html                  # Landing page para GitHub Pages
├── assets/                     # Iconos y recursos visuales
└── x86_64/
    ├── netlens-0.1.0-1-x86_64.pkg.tar.zst
    ├── netlens.db
    ├── netlens.db.tar.zst
    ├── netlens.files
    └── netlens.files.tar.zst
```
