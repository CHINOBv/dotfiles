#!/bin/bash
# install.sh - Script de instalación de dotfiles para Linux/macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d-%H%M%S)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}"
cat << "EOF"
  ____        _    __ _ _           
 |  _ \  ___ | |_ / _(_) | ___  ___ 
 | | | |/ _ \| __| |_| | |/ _ \/ __|
 | |_| | (_) | |_|  _| | |  __/\__ \
 |____/ \___/ \__|_| |_|_|\___||___/
                                    
  Linux Development Environment
  Hyprland + Neovim + Catppuccin Mocha
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

install_config() {
    local src="$1"
    local dest="$2"
    local name="$3"
    
    if [[ -e "$dest" ]]; then
        if [[ "$FORCE" == "true" ]]; then
            backup_if_exists "$dest" "$name"
        else
            echo -e "${YELLOW}[!] $name config already exists. Use --force to replace.${NC}"
            return
        fi
    fi
    
    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
    echo -e "${GREEN}[OK] $name installed to $dest${NC}"
}

# Parse arguments
FORCE="false"
SKIP_HYPRLAND="false"
for arg in "$@"; do
    case $arg in
        --force|-f)
            FORCE="true"
            ;;
        --skip-hyprland)
            SKIP_HYPRLAND="true"
            ;;
    esac
done

# Detectar distro
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    DISTRO=$ID
else
    DISTRO="unknown"
fi

echo -e "${CYAN}[*] Detected: $DISTRO${NC}\n"

# ===== NEOVIM =====
echo -e "${CYAN}[*] Installing Neovim config...${NC}"
install_config "$SCRIPT_DIR/nvim" "$CONFIG_DIR/nvim" "Neovim"

# ===== WEZTERM =====
echo -e "\n${CYAN}[*] Installing Wezterm config...${NC}"
install_config "$SCRIPT_DIR/wezterm.lua" "$HOME/.wezterm.lua" "Wezterm"

# ===== HYPRLAND (Linux only) =====
if [[ "$OSTYPE" == "linux-gnu"* ]] && [[ "$SKIP_HYPRLAND" == "false" ]]; then
    echo -e "\n${CYAN}[*] Installing Hyprland config...${NC}"
    
    # Hyprland
    mkdir -p "$CONFIG_DIR/hypr"
    install_config "$SCRIPT_DIR/hyprland/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf" "Hyprland"
    install_config "$SCRIPT_DIR/hyprland/hyprpaper.conf" "$CONFIG_DIR/hypr/hyprpaper.conf" "Hyprpaper"
    install_config "$SCRIPT_DIR/hyprland/hyprlock.conf" "$CONFIG_DIR/hypr/hyprlock.conf" "Hyprlock"
    
    # Waybar
    echo -e "\n${CYAN}[*] Installing Waybar config...${NC}"
    mkdir -p "$CONFIG_DIR/waybar"
    install_config "$SCRIPT_DIR/waybar/config.jsonc" "$CONFIG_DIR/waybar/config.jsonc" "Waybar config"
    install_config "$SCRIPT_DIR/waybar/style.css" "$CONFIG_DIR/waybar/style.css" "Waybar style"
    
    # Wofi
    echo -e "\n${CYAN}[*] Installing Wofi config...${NC}"
    mkdir -p "$CONFIG_DIR/wofi"
    install_config "$SCRIPT_DIR/wofi/config" "$CONFIG_DIR/wofi/config" "Wofi config"
    install_config "$SCRIPT_DIR/wofi/style.css" "$CONFIG_DIR/wofi/style.css" "Wofi style"
    
    # Dunst
    echo -e "\n${CYAN}[*] Installing Dunst config...${NC}"
    mkdir -p "$CONFIG_DIR/dunst"
    install_config "$SCRIPT_DIR/dunst/dunstrc" "$CONFIG_DIR/dunst/dunstrc" "Dunst"

    # Crear directorio para wallpapers
    mkdir -p "$HOME/Pictures/Wallpapers"
    mkdir -p "$HOME/Pictures/Screenshots"
fi

# ===== INFORMACIÓN =====
echo -e "\n${CYAN}========================================${NC}"
echo -e "${CYAN}  Installation complete!${NC}"
echo -e "${CYAN}========================================${NC}"

echo -e "\n${YELLOW}Required packages (Fedora):${NC}"
echo "  sudo dnf install neovim git nodejs wezterm fish"
echo "  sudo dnf install hyprland hyprpaper hyprlock waybar wofi dunst"
echo "  sudo dnf install grim slurp wl-clipboard cliphist playerctl brightnessctl"
echo "  sudo dnf install thunar pavucontrol nm-connection-editor"

echo -e "\n${YELLOW}Required packages (Arch):${NC}"
echo "  sudo pacman -S neovim git nodejs wezterm fish"
echo "  sudo pacman -S hyprland hyprpaper hyprlock waybar wofi dunst"
echo "  sudo pacman -S grim slurp wl-clipboard cliphist playerctl brightnessctl"
echo "  sudo pacman -S thunar pavucontrol nm-connection-editor"

echo -e "\n${YELLOW}Install Nerd Font:${NC}"
echo "  # Download JetBrainsMono Nerd Font from:"
echo "  https://www.nerdfonts.com/font-downloads"
echo "  # Extract to ~/.local/share/fonts/ and run: fc-cache -fv"

echo -e "\n${YELLOW}For .NET development:${NC}"
echo "  # Fedora:"
echo "  sudo dnf install dotnet-sdk-8.0"
echo "  # Install netcoredbg from:"
echo "  https://github.com/Samsung/netcoredbg/releases"

echo -e "\n${YELLOW}For Flutter development:${NC}"
echo "  # Download Flutter SDK from:"
echo "  https://flutter.dev/docs/get-started/install/linux"

echo -e "\n${YELLOW}For Go development:${NC}"
echo "  sudo dnf install golang  # Fedora"
echo "  sudo pacman -S go        # Arch"

echo -e "\n${YELLOW}For AI autocompletion (Codeium):${NC}"
echo "  1. Open Neovim and run: :Codeium Auth"
echo "  2. Follow the browser to authenticate"
echo "  3. Paste the token when prompted"

echo -e "\n${YELLOW}Wallpaper:${NC}"
echo "  Add your wallpaper to: ~/Pictures/Wallpapers/wallpaper.jpg"

echo -e "\n${YELLOW}Next steps:${NC}"
echo "  1. Log out and select Hyprland as your session"
echo "  2. Open Wezterm (Super+Return)"
echo "  3. Open Neovim to install plugins: nvim"
echo "  4. Run :Codeium Auth to enable AI completions"

echo -e "\n${GREEN}Hyprland keybindings:${NC}"
echo "  Super+Return    = Terminal (Wezterm)"
echo "  Super+Space     = App launcher (Wofi)"
echo "  Super+Q         = Close window"
echo "  Super+HJKL      = Focus window"
echo "  Super+1-9       = Switch workspace"
echo "  Super+Shift+1-9 = Move to workspace"
echo "  Super+F         = Fullscreen"
echo "  Print           = Screenshot (area)"
echo ""
