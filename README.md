# Dotfiles - Windows 11 Development Environment

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
  <img src="https://img.shields.io/badge/.NET-8.0-512BD4?style=for-the-badge&logo=dotnet&logoColor=white" alt=".NET"/>
  <img src="https://img.shields.io/badge/Windows-11-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows"/>
  <img src="https://img.shields.io/badge/Theme-Catppuccin_Mocha-fab387?style=for-the-badge" alt="Catppuccin"/>
</p>

Configuracion completa para desarrollo **.NET** en **Windows 11** con:
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

### Prerequisitos

```powershell
# Instalar con winget
winget install Neovim.Neovim
winget install wez.wezterm
winget install glzr-io.glazewm
winget install Microsoft.PowerShell
winget install Git.Git

# YASB - descargar de https://github.com/amnweb/yasb/releases
```

### Clonar e Instalar

```powershell
# Clonar repositorio
git clone https://github.com/TU_USUARIO/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles

# Ejecutar script de instalacion
.\install.ps1

# O instalar manualmente:
Copy-Item "wezterm.lua" "$HOME\.wezterm.lua"
Copy-Item -Recurse "nvim" "$env:LOCALAPPDATA\nvim"
Copy-Item -Recurse "glazewm" "$HOME\.glzr\glazewm"
Copy-Item -Recurse "yasb\*" "$HOME\.config\yasb\"
```

### Herramientas .NET

```powershell
# netcoredbg (debugger)
mkdir C:\tools\netcoredbg -Force
# Descargar de: https://github.com/Samsung/netcoredbg/releases
# Extraer en C:\tools\netcoredbg\

# Roslyn LSP (IntelliSense)
# Se instala automaticamente con el plugin roslyn.nvim
```

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
