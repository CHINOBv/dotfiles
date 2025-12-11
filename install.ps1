# install.ps1 - Script de instalacion de dotfiles
# Ejecutar: .\install.ps1

param(
    [switch]$Force,
    [switch]$SkipNeovim,
    [switch]$SkipWezterm,
    [switch]$SkipGlazeWM,
    [switch]$SkipYASB
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "`n[*] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[!] $Message" -ForegroundColor Yellow
}

function Backup-Config {
    param([string]$Path, [string]$Name)
    if (Test-Path $Path) {
        $backupPath = "$Path.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Write-Warning "Backup de $Name existente en: $backupPath"
        Move-Item $Path $backupPath
    }
}

Write-Host @"

  ____        _    __ _ _           
 |  _ \  ___ | |_ / _(_) | ___  ___ 
 | | | |/ _ \| __| |_| | |/ _ \/ __|
 | |_| | (_) | |_|  _| | |  __/\__ \
 |____/ \___/ \__|_| |_|_|\___||___/
                                    
  Windows 11 Development Environment
  Catppuccin Mocha Theme

"@ -ForegroundColor Magenta

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ===== WEZTERM =====
if (-not $SkipWezterm) {
    Write-Step "Instalando Wezterm config..."
    $weztermDest = "$HOME\.wezterm.lua"
    
    if ($Force) {
        Backup-Config $weztermDest "Wezterm"
    }
    
    Copy-Item "$scriptDir\wezterm.lua" $weztermDest -Force
    Write-Success "Wezterm config instalado en $weztermDest"
}

# ===== NEOVIM =====
if (-not $SkipNeovim) {
    Write-Step "Instalando Neovim config..."
    $nvimDest = "$env:LOCALAPPDATA\nvim"
    
    if (Test-Path $nvimDest) {
        if ($Force) {
            Backup-Config $nvimDest "Neovim"
        } else {
            Write-Warning "Neovim config ya existe. Usa -Force para reemplazar."
        }
    }
    
    if (-not (Test-Path $nvimDest) -or $Force) {
        Copy-Item -Recurse "$scriptDir\nvim" $nvimDest -Force
        Write-Success "Neovim config instalado en $nvimDest"
        Write-Host "    Abre Neovim para instalar plugins automaticamente" -ForegroundColor Gray
    }
}

# ===== GLAZEWM =====
if (-not $SkipGlazeWM) {
    Write-Step "Instalando GlazeWM config..."
    $glazeDest = "$HOME\.glzr\glazewm"
    
    if (-not (Test-Path $glazeDest)) {
        New-Item -ItemType Directory -Path $glazeDest -Force | Out-Null
    }
    
    if ($Force -and (Test-Path "$glazeDest\config.yaml")) {
        Backup-Config "$glazeDest\config.yaml" "GlazeWM"
    }
    
    Copy-Item "$scriptDir\glazewm\config.yaml" "$glazeDest\config.yaml" -Force
    Write-Success "GlazeWM config instalado en $glazeDest"
    Write-Host "    Recarga con Alt+Shift+R si GlazeWM esta corriendo" -ForegroundColor Gray
}

# ===== YASB =====
if (-not $SkipYASB) {
    Write-Step "Instalando YASB config..."
    $yasbDest = "$HOME\.config\yasb"
    
    if (-not (Test-Path $yasbDest)) {
        New-Item -ItemType Directory -Path $yasbDest -Force | Out-Null
    }
    
    if ($Force) {
        if (Test-Path "$yasbDest\config.yaml") {
            Backup-Config "$yasbDest\config.yaml" "YASB config"
        }
        if (Test-Path "$yasbDest\styles.css") {
            Backup-Config "$yasbDest\styles.css" "YASB styles"
        }
    }
    
    Copy-Item "$scriptDir\yasb\config.yaml" "$yasbDest\config.yaml" -Force
    Copy-Item "$scriptDir\yasb\styles.css" "$yasbDest\styles.css" -Force
    Write-Success "YASB config instalado en $yasbDest"
    Write-Host "    Reinicia YASB para aplicar cambios" -ForegroundColor Gray
}

# ===== GZIP (requerido para Codeium) =====
Write-Step "Verificando gzip..."
$gzipPath = Get-Command gzip -ErrorAction SilentlyContinue
if (-not $gzipPath) {
    Write-Warning "gzip no encontrado. Instalando con winget..."
    winget install GnuWin32.Gzip --accept-source-agreements --accept-package-agreements
    Write-Success "gzip instalado"
} else {
    Write-Success "gzip ya esta instalado"
}

# ===== RESUMEN =====
Write-Host @"

========================================
  Instalacion completada!
========================================

Proximos pasos:

1. Instalar netcoredbg (debugger .NET):
   - Descargar de: https://github.com/Samsung/netcoredbg/releases
   - Extraer en: C:\tools\netcoredbg\

2. Abrir Neovim para instalar plugins:
   nvim

3. Configurar Codeium (AI autocompletado):
   - En Neovim ejecutar:  :Codeium Auth
   - Seguir las instrucciones en el navegador
   - Pegar el token cuando se solicite

4. Recargar GlazeWM:
   Alt+Shift+R

5. Reiniciar YASB

Documentacion:
- GUIA-COMPLETA.md    - Referencia de keymaps
- GUIA-APRENDIZAJE.md - Tutorial de 8 semanas

"@ -ForegroundColor Green
