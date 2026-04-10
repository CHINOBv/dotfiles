# install.ps1 - Script de instalacion de dotfiles
# Ejecutar: .\install.ps1

param(
    [switch]$Force,
    [switch]$SkipNeovim,
    [switch]$SkipWezterm,
    [switch]$SkipGlazeWM,
    [switch]$SkipYASB,
    [switch]$SkipGentleAI,
    [switch]$SkipAITools,
    [switch]$OnlyGentleAI,
    [switch]$InstallGentleAI,
    [switch]$InstallAITools
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

function Get-CommandVersion {
    param([string]$CommandName)

    try {
        $version = & $CommandName version 2>$null
        if ($version) { return $version }
    }
    catch {}

    try {
        $version = & $CommandName --version 2>$null
        if ($version) { return $version }
    }
    catch {}

    return "installed"
}

function Get-GentleAIBinary {
    $cmd = Get-Command gentle-ai -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $fallbackPath = Join-Path $env:LOCALAPPDATA "gentle-ai\bin\gentle-ai.exe"
    if (Test-Path $fallbackPath) { return $fallbackPath }

    return $null
}

function Get-OpenCodeBinary {
    $cmd = Get-Command opencode -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $fallbacks = @(
        (Join-Path $HOME ".opencode\bin\opencode.exe"),
        (Join-Path $HOME ".opencode\bin\opencode")
    )

    foreach ($path in $fallbacks) {
        if (Test-Path $path) { return $path }
    }

    return $null
}

function Get-GzipBinary {
    $cmd = Get-Command gzip -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $fallbacks = @(
        (Join-Path ${env:ProgramFiles(x86)} "GnuWin32\bin\gzip.exe"),
        (Join-Path $env:ProgramFiles "GnuWin32\bin\gzip.exe"),
        (Join-Path $HOME "scoop\shims\gzip.exe")
    )

    foreach ($path in $fallbacks) {
        if ($path -and (Test-Path $path)) { return $path }
    }

    return $null
}

function Set-GzipState {
    param(
        [string]$Status,
        [string]$Detail = "",
        [string]$Path = ""
    )

    $script:GzipStatus = [ordered]@{
        Status = $Status
        Detail = $Detail
        Path = $Path
    }
}

function Show-GzipSummary {
    $line = "gzip: $($script:GzipStatus.Status)"
    if ($script:GzipStatus.Detail) {
        $line += " ($($script:GzipStatus.Detail))"
    }

    Write-Host $line -ForegroundColor Yellow

    if ($script:GzipStatus.Path) {
        Write-Host "  Path: $($script:GzipStatus.Path)" -ForegroundColor Gray
    }
}

function Set-AIToolState {
    param(
        [string]$Tool,
        [string]$Status,
        [string]$Detail = "",
        [string]$Path = ""
    )

    $script:AIToolStatus[$Tool] = [ordered]@{
        Status = $Status
        Detail = $Detail
        Path = $Path
    }
}

function Write-AIToolStatus {
    param(
        [string]$Name,
        [System.Collections.IDictionary]$State
    )

    $line = "  ${Name}: $($State.Status)"
    if ($State.Detail) {
        $line += " ($($State.Detail))"
    }

    Write-Host $line

    if ($State.Path) {
        Write-Host "    Path: $($State.Path)" -ForegroundColor Gray
    }
}

function Show-AIToolsSummary {
    Write-Host ""
    Write-Host "AI tools status:" -ForegroundColor Yellow

    Write-AIToolStatus "Gentle AI" $script:AIToolStatus["gentle-ai"]
    Write-AIToolStatus "OpenCode" $script:AIToolStatus["opencode"]
}

function Install-GentleAI {
    param([switch]$ForceInstall)

    $existing = Get-GentleAIBinary
    if ($existing -and -not $ForceInstall) {
        Set-AIToolState -Tool "gentle-ai" -Status "already installed" -Detail (Get-CommandVersion $existing) -Path $existing
        Write-Success "Gentle AI ya disponible: $(Get-CommandVersion $existing)"
        return
    }

    Write-Step "Instalando Gentle AI..."

    $installerUrl = "https://raw.githubusercontent.com/Gentleman-Programming/gentle-ai/main/scripts/install.ps1"
    $tempScript = Join-Path $env:TEMP "gentle-ai-install.ps1"

    try {
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            throw "falta el prerequisito git"
        }

        if (-not (Get-Command powershell -ErrorAction SilentlyContinue)) {
            throw "powershell no esta disponible para ejecutar el instalador oficial"
        }

        Invoke-WebRequest -Uri $installerUrl -OutFile $tempScript -UseBasicParsing
        & powershell -ExecutionPolicy Bypass -File $tempScript -Method binary

        if ($LASTEXITCODE -ne 0) {
            throw "El instalador oficial devolvio codigo $LASTEXITCODE"
        }

        $gentleAiCmd = Get-GentleAIBinary
        if ($gentleAiCmd) {
            Set-AIToolState -Tool "gentle-ai" -Status "installed" -Detail (Get-CommandVersion $gentleAiCmd) -Path $gentleAiCmd
            Write-Success "Gentle AI instalado: $(Get-CommandVersion $gentleAiCmd)"
        } else {
            throw "el instalador termino pero no se detecto el binario"
        }
    }
    catch {
        Set-AIToolState -Tool "gentle-ai" -Status "failed" -Detail $_.Exception.Message -Path $existing
        throw "No se pudo instalar Gentle AI: $($_.Exception.Message)"
    }
    finally {
        if (Test-Path $tempScript) {
            Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
        }
    }
}

function Install-OpenCode {
    param([switch]$ForceInstall)

    $existing = Get-OpenCodeBinary
    if ($existing -and -not $ForceInstall) {
        Set-AIToolState -Tool "opencode" -Status "already installed" -Detail (Get-CommandVersion $existing) -Path $existing
        Write-Success "OpenCode ya disponible: $(Get-CommandVersion $existing)"
        return
    }

    Write-Step "Instalando OpenCode..."

    $scoopError = $null
    $npmError = $null
    $scoopCmd = Get-Command scoop -ErrorAction SilentlyContinue
    if ($scoopCmd) {
        try {
            & scoop install opencode
            if ($LASTEXITCODE -eq 0) {
                $installed = Get-OpenCodeBinary
                if ($installed) {
                    Set-AIToolState -Tool "opencode" -Status "installed" -Detail (Get-CommandVersion $installed) -Path $installed
                    Write-Success "OpenCode instalado: $(Get-CommandVersion $installed)"
                    return
                }

                $scoopError = "scoop finalizo sin error pero no dejo el binario disponible"
            }
            else {
                $scoopError = "scoop devolvio codigo $LASTEXITCODE"
            }
        }
        catch {
            $scoopError = $_.Exception.Message
            Write-Warning "Scoop fallo instalando OpenCode, intentando npm global..."
        }
    }
    else {
        $scoopError = "scoop no esta instalado"
    }

    $npmCmd = Get-Command npm -ErrorAction SilentlyContinue
    if ($npmCmd) {
        try {
            & npm install -g opencode-ai@latest
            if ($LASTEXITCODE -ne 0) {
                throw "npm devolvio codigo $LASTEXITCODE"
            }

            $installed = Get-OpenCodeBinary
            if ($installed) {
                Set-AIToolState -Tool "opencode" -Status "installed" -Detail (Get-CommandVersion $installed) -Path $installed
                Write-Success "OpenCode instalado: $(Get-CommandVersion $installed)"
                return
            }

            $npmError = "npm finalizo sin error pero no dejo el binario disponible"
        }
        catch {
            $npmError = $_.Exception.Message
        }
    }
    else {
        $npmError = "npm no esta instalado"
    }

    $detail = "Scoop: $scoopError; npm: $npmError"
    Set-AIToolState -Tool "opencode" -Status "failed" -Detail $detail -Path $existing
    throw "No se pudo instalar OpenCode. $detail"
}

$script:AIToolStatus = @{
    "gentle-ai" = [ordered]@{ Status = "pending"; Detail = ""; Path = "" }
    "opencode" = [ordered]@{ Status = "pending"; Detail = ""; Path = "" }
}

$script:GzipStatus = [ordered]@{ Status = "pending"; Detail = ""; Path = "" }

if ($SkipGentleAI -or $SkipAITools) {
    Set-AIToolState -Tool "gentle-ai" -Status "skipped" -Detail "not requested"
}

if ($OnlyGentleAI) {
    Set-AIToolState -Tool "opencode" -Status "skipped" -Detail "only Gentle AI mode"
}
elseif ($SkipAITools) {
    Set-AIToolState -Tool "opencode" -Status "skipped" -Detail "not requested"
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

if ($OnlyGentleAI) {
    try {
        Install-GentleAI -ForceInstall
        Write-Success "Instalacion de Gentle AI completada"
        Show-AIToolsSummary
        exit 0
    }
    catch {
        Write-Warning $_.Exception.Message
        Show-AIToolsSummary
        exit 1
    }
}

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

# ===== AI TOOLS =====
if ($SkipAITools) {
    Write-Warning "Saltando instalacion de OpenCode y Gentle AI"
}
else {
    if ($SkipGentleAI) {
        Set-AIToolState -Tool "gentle-ai" -Status "skipped" -Detail "not requested"
        Write-Warning "Saltando instalacion de Gentle AI"
    }
    else {
        try {
            if ($InstallGentleAI -or $InstallAITools) {
                Install-GentleAI -ForceInstall
            }
            else {
                Install-GentleAI
            }
        }
        catch {
            Write-Warning $_.Exception.Message
            Write-Warning "Continuando sin Gentle AI"
        }
    }

    try {
        if ($InstallAITools) {
            Install-OpenCode -ForceInstall
        }
        else {
            Install-OpenCode
        }
    }
    catch {
        Write-Warning $_.Exception.Message
        Write-Warning "Continuando sin OpenCode"
    }
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
$gzipPath = Get-GzipBinary
if ($gzipPath) {
    Set-GzipState -Status "already installed" -Path $gzipPath
    Write-Success "gzip ya esta instalado"
}
else {
    $wingetPath = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $wingetPath) {
        Set-GzipState -Status "failed" -Detail "winget no esta disponible"
        Write-Warning "gzip no encontrado y winget no esta disponible. Codeium puede requerir instalacion manual de gzip."
    }
    else {
        Write-Warning "gzip no encontrado. Instalando con winget..."

        try {
            & winget install --id GnuWin32.Gzip -e --accept-source-agreements --accept-package-agreements
            if ($LASTEXITCODE -ne 0) {
                throw "winget devolvio codigo $LASTEXITCODE"
            }

            $installedGzip = Get-GzipBinary
            if ($installedGzip) {
                Set-GzipState -Status "installed" -Path $installedGzip
                Write-Success "gzip instalado"
            }
            else {
                Set-GzipState -Status "installed" -Detail "no se detecto en la sesion actual; reabre la terminal o verifica PATH"
                Write-Warning "winget termino sin error, pero gzip no quedo disponible en esta sesion. Reabre la terminal o verifica PATH."
            }
        }
        catch {
            Set-GzipState -Status "failed" -Detail $_.Exception.Message
            Write-Warning "No se pudo instalar gzip: $($_.Exception.Message)"
            Write-Warning "Codeium puede requerir instalacion manual de gzip."
        }
    }
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
"@ -ForegroundColor Green

Show-AIToolsSummary
Show-GzipSummary

Write-Host @"

Gentle AI:
- Se instala automaticamente por defecto
- Solo Gentle AI: .\install.ps1 -OnlyGentleAI
- Forzar Gentle AI: .\install.ps1 -InstallGentleAI
- Omitir Gentle AI: .\install.ps1 -SkipGentleAI
- Ejecutar: gentle-ai

AI Tools:
- OpenCode + Gentle AI ya se instalan por defecto
- Forzar OpenCode + Gentle AI: .\install.ps1 -InstallAITools
- Omitir ambos: .\install.ps1 -SkipAITools
- Ejecutar OpenCode: opencode

Documentacion:
- GUIA-COMPLETA.md    - Referencia de keymaps
- GUIA-APRENDIZAJE.md - Tutorial de 8 semanas

"@ -ForegroundColor Green
