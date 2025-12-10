# 🚀 LazyVim + C#/.NET Configuration

Configuración completa de Neovim con LazyVim optimizada para desarrollo profesional en C# y .NET, con integración de OpenCode y una UI espectacular.

## ✨ Características

- **LazyVim** como base sólida y moderna
- **Roslyn LSP** (Microsoft oficial) para C#/.NET
- **Catppuccin Mocha** con transparencia
- **Alpha Dashboard** con logo personalizado por proyecto
- **Animaciones suaves** (neoscroll + mini.animate)
- **Debugging** con netcoredbg
- **OpenCode** totalmente integrado
- **Efectos visuales** completos (rainbow delimiters, todo-comments, illuminate, etc.)

---

## 📋 Requisitos Previos

### Obligatorios

- Neovim >= 0.11.0
- Git >= 2.19.0
- Nerd Font (FiraCode Nerd Font recomendada)
- .NET SDK 10
- PowerShell 7

### Recomendados

- `ripgrep` - Para búsqueda de texto
- `fd` - Para búsqueda de archivos
- `lazygit` - Git TUI
- `fzf` - Fuzzy finder
- `CSharpier` - Formateador C#
- `netcoredbg` - Debugger .NET

### Instalación de herramientas en Windows

```powershell
# Con scoop
scoop install ripgrep fd lazygit fzf

# O con winget
winget install BurntSushi.ripgrep.MSVC sharkdp.fd JesseDuffield.lazygit junegunn.fzf

# CSharpier (formateador)
dotnet tool install -g csharpier

# netcoredbg (debugging)
# Descargar desde: https://github.com/Samsung/netcoredbg/releases
```

---

## ⌨️ Keymaps Principales

### .NET Específico (`<Space>d`)

| Keymap | Acción |
|--------|--------|
| `<Space>db` | Build |
| `<Space>dr` | Run |
| `<Space>dt` | Test |
| `<Space>dw` | Watch (hot reload) |
| `<Space>dc` | Clean |
| `<Space>dR` | Restore packages |
| `<Space>dp` | Add NuGet package |
| `<Space>dP` | Remove NuGet package |
| `<Space>ds` | Switch solution |
| `<Space>di` | Info del proyecto |

### OpenCode (`<Space>o`)

| Keymap | Acción |
|--------|--------|
| `<Space>oo` | Abrir OpenCode |
| `<Space>on` | Nueva sesión |
| `<Space>oi` | Init proyecto |
| `<Space>os` | Share conversación |
| `<Space>of` | Enviar archivo actual |
| `<Space>ov` | Enviar selección (visual) |

### Debug (`<Space>D`)

| Keymap | Acción |
|--------|--------|
| `<Space>Db` | Toggle breakpoint |
| `<Space>DB` | Breakpoint condicional |
| `<Space>Dc` | Continue |
| `<Space>Di` | Step into |
| `<Space>Do` | Step over |
| `<Space>DO` | Step out |
| `<Space>Dt` | Terminate |
| `<Space>Du` | Toggle UI debug |

---

## 🚀 Primer Uso

1. **Abrir Neovim por primera vez:**
   ```bash
   nvim
   ```

2. **Esperar a que Lazy instale los plugins** (puede tardar 1-2 minutos)

3. **Instalar Roslyn LSP:**
   ```vim
   :Mason
   ```
   Buscar `roslyn` e instalar

4. **Verificar salud:**
   ```vim
   :checkhealth
   ```

5. **Abrir un proyecto .NET:**
   ```bash
   cd tu-proyecto-dotnet
   nvim Program.cs
   ```

---

## 🎯 Configuración por Proyecto

Puedes crear configuraciones específicas por proyecto:

```
tu-proyecto/
├── .nvim/
│   └── logo.txt          # Logo personalizado del dashboard
├── src/
└── tests/
```

### Ejemplo de logo personalizado

```bash
mkdir .nvim
# Agrega tu ASCII art en .nvim/logo.txt
```

---

## 📝 Tips y Trucos

### Mostrar todos los keymaps

Presiona `<Space>` y espera 300ms - aparecerá which-key con todas las opciones.

### Buscar archivo rápidamente

`<Space><Space>` - Abre Telescope find_files

### Ver TODOs del proyecto

`<Space>st` - Telescope TODOs

### OpenCode workflow

1. `<Space>oi` - Inicializar proyecto
2. Enviar archivos con `<Space>of`
3. Hacer preguntas en el chat
4. `<Space>os` - Compartir conversación

---

## 📚 Recursos

- [LazyVim Docs](https://www.lazyvim.org/)
- [Roslyn.nvim](https://github.com/seblyng/roslyn.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [OpenCode Docs](https://opencode.ai/docs)

---

**Hecho con ❤️ para desarrollo en C#/.NET**
