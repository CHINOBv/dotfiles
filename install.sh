#!/bin/bash
# install.sh - Script de instalación de dotfiles para Linux/macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d-%H%M%S)"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
cat << "EOF"
  ____        _    __ _ _           
 |  _ \  ___ | |_ / _(_) | ___  ___ 
 | | | |/ _ \| __| |_| | |/ _ \/ __|
 | |_| | (_) | |_|  _| | |  __/\__ \
 |____/ \___/ \__|_| |_|_|\___||___/
                                    
  Linux/macOS Development Environment
  Catppuccin Mocha Theme
EOF
echo -e "${NC}"

# Funciones
backup_if_exists() {
    local path="$1"
    local name="$2"
    if [[ -e "$path" ]]; then
        echo -e "${YELLOW}[!] Backing up existing $name to ${path}${BACKUP_SUFFIX}${NC}"
        mv "$path" "${path}${BACKUP_SUFFIX}"
    fi
}

# ===== NEOVIM =====
echo -e "\n${CYAN}[*] Installing Neovim config...${NC}"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [[ -d "$NVIM_DIR" ]]; then
    if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
        backup_if_exists "$NVIM_DIR" "Neovim"
    else
        echo -e "${YELLOW}[!] Neovim config already exists. Use --force to replace.${NC}"
    fi
fi

if [[ ! -d "$NVIM_DIR" ]] || [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
    cp -r "$SCRIPT_DIR/nvim" "$NVIM_DIR"
    echo -e "${GREEN}[OK] Neovim config installed to $NVIM_DIR${NC}"
fi

# ===== WEZTERM =====
echo -e "\n${CYAN}[*] Installing Wezterm config...${NC}"
WEZTERM_CONFIG="$HOME/.wezterm.lua"

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
    backup_if_exists "$WEZTERM_CONFIG" "Wezterm"
fi

cp "$SCRIPT_DIR/wezterm.lua" "$WEZTERM_CONFIG"
echo -e "${GREEN}[OK] Wezterm config installed to $WEZTERM_CONFIG${NC}"

# ===== GlazeWM (Windows only, skip on Linux) =====
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    echo -e "\n${CYAN}[*] Installing GlazeWM config...${NC}"
    GLAZE_DIR="$HOME/.glzr/glazewm"
    mkdir -p "$GLAZE_DIR"
    cp "$SCRIPT_DIR/glazewm/config.yaml" "$GLAZE_DIR/config.yaml"
    echo -e "${GREEN}[OK] GlazeWM config installed${NC}"
else
    echo -e "\n${YELLOW}[*] Skipping GlazeWM (Windows only)${NC}"
fi

# ===== Información sobre dependencias =====
echo -e "\n${CYAN}========================================${NC}"
echo -e "${CYAN}  Installation complete!${NC}"
echo -e "${CYAN}========================================${NC}"

echo -e "\n${YELLOW}Required dependencies:${NC}"
echo "  - Neovim >= 0.10"
echo "  - Git"
echo "  - Node.js (for treesitter)"
echo "  - A Nerd Font (JetBrainsMono recommended)"

echo -e "\n${YELLOW}For .NET development:${NC}"
echo "  - .NET SDK 8.0+"
echo "  - netcoredbg (for debugging)"
echo ""
echo "Install netcoredbg on Linux:"
echo "  # Ubuntu/Debian"
echo "  wget https://github.com/Samsung/netcoredbg/releases/latest/download/netcoredbg-linux-amd64.tar.gz"
echo "  sudo tar -xzf netcoredbg-linux-amd64.tar.gz -C /usr/local/bin"
echo ""
echo "  # Or via AUR (Arch)"
echo "  yay -S netcoredbg"

echo -e "\n${YELLOW}Next steps:${NC}"
echo "  1. Open Neovim to install plugins: nvim"
echo "  2. Wait for plugins to install"
echo "  3. Restart Neovim"
echo ""
