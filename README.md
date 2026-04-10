# Dotfiles - Cross-Platform Development Environment

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
  <img src="https://img.shields.io/badge/.NET-8.0-512BD4?style=for-the-badge&logo=dotnet&logoColor=white" alt=".NET"/>
  <img src="https://img.shields.io/badge/Windows-11-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows"/>
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux"/>
  <img src="https://img.shields.io/badge/Theme-Catppuccin_Mocha-fab387?style=for-the-badge" alt="Catppuccin"/>
</p>

Configuracion **multiplataforma** para desarrollo **.NET** con:
- **Neovim** (LazyVim) - Editor con LSP, debugging y snippets para C#
- **Wezterm** - Terminal GPU-accelerated
- **GlazeWM** - Tiling window manager
- **YASB** - Status bar minimalista

## Preview

```
+------------------+  +------------------+  +------------------+
|   Monitor 1      |  |   Monitor 2      |  |   Monitor 3      |
|   (Comms/Music)  |  |   (Terminal)     |  |   (IDE/Editor)   |
|   WS 4-5         |  |   WS 2-3         |  |   WS 1           |
+------------------+  +------------------+  +------------------+
                           |
                    [====YASB Bar====]
```

## Estructura

```
dotfiles/
├── nvim/                    # Neovim config (LazyVim)
│   ├── lua/
│   │   ├── config/          # Opciones, keymaps, autocmds
│   │   └── plugins/         # 17 plugins configurados
│   └── init.lua
├── glazewm/                 # Tiling window manager
│   └── config.yaml
├── yasb/                    # Status bar
│   ├── config.yaml
│   └── styles.css
├── wezterm.lua              # Terminal config
├── GUIA-COMPLETA.md         # Referencia de keymaps (~24KB)
└── GUIA-APRENDIZAJE.md      # Tutorial paso a paso (8 semanas)
```

## Instalacion Rapida

### Windows

```powershell
# Prerequisitos con winget
winget install Neovim.Neovim
winget install wez.wezterm
winget install glzr-io.glazewm
winget install Microsoft.PowerShell
winget install Git.Git

# Clonar e instalar
git clone https://github.com/TU_USUARIO/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
.\install.ps1

# netcoredbg (debugger)
mkdir C:\tools\netcoredbg -Force
# Descargar de: https://github.com/Samsung/netcoredbg/releases
# Extraer en C:\tools\netcoredbg\
```

### Linux

```bash
# Prerequisitos (Ubuntu/Debian)
sudo apt install neovim git nodejs npm

# Prerequisitos (Fedora)
sudo dnf install neovim git nodejs dotnet-sdk-8.0

# Prerequisitos (Arch)
sudo pacman -S neovim git nodejs npm

# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update && sudo apt install wezterm

# Clonar e instalar
git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

# Instalar herramientas de desarrollo (elige una opcion)
./install.sh --install-dev-tools    # Todas las herramientas
./install.sh --install-netcoredbg   # Solo .NET debugger
./install.sh --install-flutter      # Solo Flutter SDK
./install.sh --install-go           # Solo Go
```

### Opciones del script de instalacion

```bash
./install.sh --help                 # Ver todas las opciones
./install.sh --force                # Reemplazar configs existentes
./install.sh --skip-hyprland        # Omitir Hyprland/Waybar/etc
./install.sh --install-dev-tools    # Instalar netcoredbg + Flutter + Go
./install.sh --install-ai-tools     # Forzar OpenCode + Gentle AI
./install.sh --only-gentle-ai       # Instalar/actualizar solo Gentle AI
./install.sh --install-gentle-ai    # Forzar instalacion/actualizacion de Gentle AI
./install.sh --skip-ai-tools        # Omitir OpenCode + Gentle AI
./install.sh --skip-gentle-ai       # Omitir Gentle AI durante la instalacion
```

### Instalacion manual de herramientas

<details>
<summary>netcoredbg (.NET debugger)</summary>

```bash
# 1. Descargar de: https://github.com/Samsung/netcoredbg/releases
# 2. Extraer e instalar:
mkdir -p ~/.local/share/netcoredbg
tar -xzf netcoredbg-linux-amd64.tar.gz -C ~/.local/share/netcoredbg
# 3. Agregar al PATH (~/.bashrc):
echo 'export PATH="$HOME/.local/share/netcoredbg/netcoredbg:$PATH"' >> ~/.bashrc
source ~/.bashrc
# 4. Verificar:
netcoredbg --version

# Arch (AUR):
yay -S netcoredbg
```
</details>

<details>
<summary>Flutter SDK</summary>

```bash
# 1. Descargar de: https://flutter.dev/docs/get-started/install/linux
# 2. Extraer:
mkdir -p ~/.local/share
tar -xf flutter_linux_*.tar.xz -C ~/.local/share
# 3. Agregar al PATH (~/.bashrc):
echo 'export PATH="$HOME/.local/share/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
# 4. Verificar:
flutter doctor
```
</details>

<details>
<summary>Go</summary>

```bash
# Opcion 1: Package manager
sudo dnf install golang  # Fedora
sudo pacman -S go        # Arch

# Opcion 2: Manual
# 1. Descargar de: https://go.dev/dl/
# 2. Extraer:
sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
# 3. Agregar al PATH (~/.bashrc):
echo 'export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
# 4. Verificar:
go version
```
</details>

### macOS

```bash
# Prerequisitos con Homebrew
brew install neovim git node
brew install --cask wezterm

# Clonar e instalar
git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh

# netcoredbg
brew install netcoredbg
```

### Roslyn LSP (IntelliSense C#)

Se instala automaticamente con el plugin `roslyn.nvim` en todas las plataformas.

## Gentle AI

`Gentle AI` se instala automaticamente por defecto en Linux/macOS y Windows.

Si ya esta instalado, el script no lo reinstala salvo que lo fuerces con la opcion dedicada.

## AI Tools

`OpenCode` y `Gentle AI` ahora se instalan automaticamente por defecto.

Si ya existen, el installer no los reinstala salvo que uses la opcion para forzar actualizacion.

### Instalar OpenCode + Gentle AI

#### Linux / macOS

```bash
./install.sh --install-ai-tools
```

#### Windows

```powershell
.\install.ps1 -InstallAITools
```

En Windows, OpenCode se instala con este orden de prioridad:
1. `scoop install opencode`
2. `npm install -g opencode-ai@latest`

Si no existe `scoop` ni `npm`, la instalacion de OpenCode falla de forma explicita.

### Omitir OpenCode + Gentle AI

#### Linux / macOS

```bash
./install.sh --skip-ai-tools
```

#### Windows

```powershell
.\install.ps1 -SkipAITools
```

### Instalar solo Gentle AI

#### Linux / macOS

```bash
./install.sh --only-gentle-ai
```

#### Windows

```powershell
.\install.ps1 -OnlyGentleAI
```

### Forzar instalacion/actualizacion de Gentle AI

#### Linux / macOS

```bash
./install.sh --install-gentle-ai
```

#### Windows

```powershell
.\install.ps1 -InstallGentleAI
```

### Omitir Gentle AI durante la instalacion

#### Linux / macOS

```bash
./install.sh --skip-gentle-ai
```

#### Windows

```powershell
.\install.ps1 -SkipGentleAI
```

### Ejecutar Gentle AI

```bash
gentle-ai
```

La instalacion delega al instalador oficial del proyecto:
- Linux/macOS: `scripts/install.sh` de `Gentleman-Programming/gentle-ai`
- Windows: `scripts/install.ps1` de `Gentleman-Programming/gentle-ai`

Eso reduce mantenimiento local y mantiene el flujo alineado con upstream.

## Keymaps Principales

### GlazeWM (Window Manager)

| Keybind | Accion |
|---------|--------|
| `Alt + h/j/k/l` | Focus ventana |
| `Alt + Shift + h/j/k/l` | Mover ventana |
| `Alt + 1-9` | Ir a workspace |
| `Alt + Shift + 1-9` | Mover a workspace |
| `Alt + f` | Toggle fullscreen |
| `Alt + Shift + Space` | Toggle floating |
| `Alt + Shift + q` | Cerrar ventana |
| `Alt + Shift + r` | Recargar config |

### Neovim

| Keybind | Accion |
|---------|--------|
| `Space` | Leader key |
| `Ctrl + s` | Guardar |
| `Ctrl + h/j/k/l` | Navegar splits |
| `Ctrl + Shift + j/k` | Mover lineas |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Grep en proyecto |
| `<leader>e` | File explorer |

### Debug (.NET)

| Keybind | Accion |
|---------|--------|
| `F5` | Iniciar/Continuar |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `Shift + F11` | Step out |
| `Shift + F5` | Terminar |

### Harpoon (Navegacion Rapida)

| Keybind | Accion |
|---------|--------|
| `<leader>ha` | Agregar archivo |
| `<leader>hh` | Menu Harpoon |
| `<leader>1-5` | Ir a archivo N |

### Database Clients

| Keybind | Accion |
|---------|--------|
| `<leader>Ds` | SQL UI (DBUI) |
| `<leader>Dt` | SQL Server |
| `<leader>Dp` | PostgreSQL |
| `<leader>Dm` | MongoDB |
| `<leader>Dr` | Redis |

### Wezterm

| Keybind | Accion |
|---------|--------|
| `Ctrl+a` | Leader key |
| `Leader + -` | Split horizontal |
| `Leader + \|` | Split vertical |
| `Leader + h/j/k/l` | Navegar panes |
| `Leader + z` | Zoom pane |
| `Leader + c` | Nueva tab |
| `Leader + 1-9` | Ir a tab N |

## Plugins de Neovim

| Plugin | Descripcion |
|--------|-------------|
| **trouble.nvim** | Panel de diagnósticos (problemas) |
| **tiny-inline-diagnostic** | UI mejorada para errores inline |
| **catppuccin** | Tema Mocha con transparencia |
| **roslyn.nvim** | LSP para C# (IntelliSense) |
| **nvim-dap** | Debugging con fix para Windows paths |
| **LuaSnip** | 40+ snippets para C# |
| **harpoon** | Navegacion rapida entre archivos |
| **vim-dadbod** | Cliente SQL multi-database |
| **telescope** | Fuzzy finder |
| **neo-tree** | File explorer |
| **toggleterm** | Terminal integrada |
| **which-key** | Ayuda de keymaps |
| **mini.animate** | Animaciones suaves |
| **bufferline** | Tabs de buffers |
| **noice** | UI mejorada |

## Snippets C# Incluidos

```
prop     -> Propiedad con getter/setter
propg    -> Propiedad get-only
ctor     -> Constructor
ctordi   -> Constructor con DI
httpget  -> Controller GET endpoint
httppost -> Controller POST endpoint
asyncm   -> Metodo async Task
guard    -> Guard clause (ArgumentNullException)
record   -> Record con propiedades
test     -> Test method (xUnit)
testasync-> Test async method
```

Ver lista completa en `GUIA-COMPLETA.md`

## Tema: Catppuccin Mocha

Toda la configuracion usa la paleta **Catppuccin Mocha**:

| Elemento | Color | Hex |
|----------|-------|-----|
| Ventana activa | Peach | `#fab387` |
| Ventana inactiva | Surface1 | `#45475a` |
| Workspace activo | Peach | `#fab387` |
| Fondo | Base | `#1e1e2e` |
| Texto | Text | `#cdd6f4` |

## Notas Tecnicas

- **DAP Fix**: El debugger incluye un fix para convertir paths `/` a `\` en Windows
- **Alt+Enter**: Liberado en Wezterm y GlazeWM para uso en aplicaciones
- **Alt+Arrows**: Liberado para navegacion por palabras en terminal
- **Transparencia**: Habilitada en Wezterm (92% opacity) y GlazeWM

## Documentacion

- `GUIA-COMPLETA.md` - Referencia completa de todos los keymaps y configuraciones
- `GUIA-APRENDIZAJE.md` - Tutorial progresivo de 8 semanas para dominar Neovim

## Workspaces (3 monitores)

| WS | Monitor | Uso |
|----|---------|-----|
| 1 | Derecho | IDE/Editor principal |
| 2 | Centro | Terminal de desarrollo |
| 3 | Centro | Web Browser |
| 4 | Izquierdo | Comunicacion (Slack, Teams) |
| 5 | Izquierdo | Musica |
| 6-9 | Dinamico | Design, Docker, Logs, Misc |

## License

MIT
