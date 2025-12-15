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
INSTALL_NETCOREDBG="false"
INSTALL_FLUTTER="false"
INSTALL_GO="false"
INSTALL_ALL_DEV="false"
INSTALL_HYPRPANEL="false"
for arg in "$@"; do
    case $arg in
        --force|-f)
            FORCE="true"
            ;;
        --skip-hyprland)
            SKIP_HYPRLAND="true"
            ;;
        --install-netcoredbg)
            INSTALL_NETCOREDBG="true"
            ;;
        --install-flutter)
            INSTALL_FLUTTER="true"
            ;;
        --install-go)
            INSTALL_GO="true"
            ;;
        --install-dev-tools)
            INSTALL_NETCOREDBG="true"
            INSTALL_FLUTTER="true"
            INSTALL_GO="true"
            ;;
        --install-hyprpanel)
            INSTALL_HYPRPANEL="true"
            ;;
        --help|-h)
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -f, --force           Backup and replace existing configs"
            echo "  --skip-hyprland       Skip Hyprland/Waybar/Wofi/Dunst installation"
            echo "  --install-netcoredbg  Install .NET debugger (netcoredbg)"
            echo "  --install-flutter     Install Flutter SDK"
            echo "  --install-go          Install Go programming language"
            echo "  --install-dev-tools   Install all dev tools (netcoredbg, flutter, go)"
            echo "  --install-hyprpanel   Install HyprPanel (replaces Waybar)"
            echo "  -h, --help            Show this help message"
            exit 0
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

# ===== TERMINALS =====
echo -e "\n${CYAN}[*] Installing terminal configs...${NC}"

# Wezterm
install_config "$SCRIPT_DIR/wezterm.lua" "$HOME/.wezterm.lua" "Wezterm"

# Kitty
if [[ -d "$SCRIPT_DIR/kitty" ]]; then
    mkdir -p "$CONFIG_DIR/kitty"
    install_config "$SCRIPT_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf" "Kitty"
fi

# Ghostty
if [[ -d "$SCRIPT_DIR/ghostty" ]]; then
    mkdir -p "$CONFIG_DIR/ghostty"
    install_config "$SCRIPT_DIR/ghostty/config" "$CONFIG_DIR/ghostty/config" "Ghostty"
fi

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

# ===== NETCOREDBG (.NET Debugger) =====
install_netcoredbg() {
    echo -e "\n${CYAN}[*] Installing netcoredbg...${NC}"
    
    NETCOREDBG_DIR="$HOME/.local/share/netcoredbg"
    NETCOREDBG_BIN="$NETCOREDBG_DIR/netcoredbg/netcoredbg"
    
    # Check if already installed
    if [[ -x "$NETCOREDBG_BIN" ]]; then
        echo -e "${YELLOW}[!] netcoredbg already installed at $NETCOREDBG_BIN${NC}"
        "$NETCOREDBG_BIN" --version
        return 0
    fi
    
    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            NETCOREDBG_ARCH="amd64"
            ;;
        aarch64)
            NETCOREDBG_ARCH="arm64"
            ;;
        *)
            echo -e "${RED}[!] Unsupported architecture: $ARCH${NC}"
            return 1
            ;;
    esac
    
    # Get latest release URL
    RELEASE_URL="https://github.com/Samsung/netcoredbg/releases/latest/download/netcoredbg-linux-${NETCOREDBG_ARCH}.tar.gz"
    TEMP_FILE="/tmp/netcoredbg.tar.gz"
    
    echo -e "${CYAN}[*] Downloading netcoredbg for ${NETCOREDBG_ARCH}...${NC}"
    if ! curl -fSL "$RELEASE_URL" -o "$TEMP_FILE"; then
        echo -e "${RED}[!] Failed to download netcoredbg${NC}"
        return 1
    fi
    
    # Create directory and extract
    mkdir -p "$NETCOREDBG_DIR"
    echo -e "${CYAN}[*] Extracting to $NETCOREDBG_DIR...${NC}"
    tar -xzf "$TEMP_FILE" -C "$NETCOREDBG_DIR"
    rm -f "$TEMP_FILE"
    
    # Add to PATH in .bashrc if not already present
    BASHRC="$HOME/.bashrc"
    PATH_LINE='export PATH="$HOME/.local/share/netcoredbg/netcoredbg:$PATH"'
    
    if ! grep -q "netcoredbg" "$BASHRC" 2>/dev/null; then
        echo -e "\n${CYAN}[*] Adding netcoredbg to PATH in ~/.bashrc...${NC}"
        echo "" >> "$BASHRC"
        echo "# netcoredbg - .NET debugger" >> "$BASHRC"
        echo "$PATH_LINE" >> "$BASHRC"
    fi
    
    # Also add to fish config if fish is installed
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    if command -v fish &> /dev/null; then
        mkdir -p "$(dirname "$FISH_CONFIG")"
        if ! grep -q "netcoredbg" "$FISH_CONFIG" 2>/dev/null; then
            echo -e "${CYAN}[*] Adding netcoredbg to PATH in fish config...${NC}"
            echo "" >> "$FISH_CONFIG"
            echo "# netcoredbg - .NET debugger" >> "$FISH_CONFIG"
            echo 'set -gx PATH $HOME/.local/share/netcoredbg/netcoredbg $PATH' >> "$FISH_CONFIG"
        fi
    fi
    
    # Verify installation
    if [[ -x "$NETCOREDBG_BIN" ]]; then
        echo -e "${GREEN}[OK] netcoredbg installed successfully!${NC}"
        echo -e "${CYAN}[*] Version: $("$NETCOREDBG_BIN" --version)${NC}"
        echo -e "${YELLOW}[!] Run 'source ~/.bashrc' or restart your terminal to use netcoredbg${NC}"
    else
        echo -e "${RED}[!] Installation failed${NC}"
        return 1
    fi
}

if [[ "$INSTALL_NETCOREDBG" == "true" ]]; then
    install_netcoredbg
fi

# ===== FLUTTER =====
install_flutter() {
    echo -e "\n${CYAN}[*] Installing Flutter SDK...${NC}"
    
    FLUTTER_DIR="$HOME/.local/share/flutter"
    FLUTTER_BIN="$FLUTTER_DIR/bin/flutter"
    
    # Check if already installed
    if [[ -x "$FLUTTER_BIN" ]]; then
        echo -e "${YELLOW}[!] Flutter already installed at $FLUTTER_DIR${NC}"
        "$FLUTTER_BIN" --version
        return 0
    fi
    
    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            FLUTTER_ARCH="x64"
            ;;
        aarch64)
            FLUTTER_ARCH="arm64"
            ;;
        *)
            echo -e "${RED}[!] Unsupported architecture: $ARCH${NC}"
            return 1
            ;;
    esac
    
    # Get latest stable Flutter
    echo -e "${CYAN}[*] Fetching latest Flutter version...${NC}"
    FLUTTER_RELEASES_URL="https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json"
    
    # Get the latest stable release URL
    FLUTTER_URL=$(curl -s "$FLUTTER_RELEASES_URL" | grep -o "https://[^\"]*linux[^\"]*stable[^\"]*${FLUTTER_ARCH}[^\"]*tar.xz" | head -1)
    
    if [[ -z "$FLUTTER_URL" ]]; then
        # Fallback to a known stable version
        echo -e "${YELLOW}[!] Could not fetch latest version, using fallback...${NC}"
        FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz"
    fi
    
    TEMP_FILE="/tmp/flutter.tar.xz"
    
    echo -e "${CYAN}[*] Downloading Flutter...${NC}"
    echo -e "${CYAN}    URL: $FLUTTER_URL${NC}"
    if ! curl -fSL "$FLUTTER_URL" -o "$TEMP_FILE"; then
        echo -e "${RED}[!] Failed to download Flutter${NC}"
        return 1
    fi
    
    # Create directory and extract
    mkdir -p "$(dirname "$FLUTTER_DIR")"
    echo -e "${CYAN}[*] Extracting Flutter to $FLUTTER_DIR...${NC}"
    tar -xf "$TEMP_FILE" -C "$(dirname "$FLUTTER_DIR")"
    rm -f "$TEMP_FILE"
    
    # Add to PATH in .bashrc
    BASHRC="$HOME/.bashrc"
    if ! grep -q "flutter/bin" "$BASHRC" 2>/dev/null; then
        echo -e "${CYAN}[*] Adding Flutter to PATH in ~/.bashrc...${NC}"
        echo "" >> "$BASHRC"
        echo "# Flutter SDK" >> "$BASHRC"
        echo 'export PATH="$HOME/.local/share/flutter/bin:$PATH"' >> "$BASHRC"
    fi
    
    # Add to fish config if fish is installed
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    if command -v fish &> /dev/null; then
        mkdir -p "$(dirname "$FISH_CONFIG")"
        if ! grep -q "flutter/bin" "$FISH_CONFIG" 2>/dev/null; then
            echo -e "${CYAN}[*] Adding Flutter to PATH in fish config...${NC}"
            echo "" >> "$FISH_CONFIG"
            echo "# Flutter SDK" >> "$FISH_CONFIG"
            echo 'set -gx PATH $HOME/.local/share/flutter/bin $PATH' >> "$FISH_CONFIG"
        fi
    fi
    
    # Verify installation
    if [[ -x "$FLUTTER_BIN" ]]; then
        echo -e "${GREEN}[OK] Flutter installed successfully!${NC}"
        # Run flutter precache to download necessary artifacts
        echo -e "${CYAN}[*] Running flutter precache...${NC}"
        "$FLUTTER_BIN" precache --no-android --no-ios --no-web --linux 2>/dev/null || true
        "$FLUTTER_BIN" --version
        echo -e "${YELLOW}[!] Run 'source ~/.bashrc' or restart your terminal${NC}"
        echo -e "${YELLOW}[!] Then run 'flutter doctor' to check dependencies${NC}"
    else
        echo -e "${RED}[!] Installation failed${NC}"
        return 1
    fi
}

if [[ "$INSTALL_FLUTTER" == "true" ]]; then
    install_flutter
fi

# ===== GO =====
install_go() {
    echo -e "\n${CYAN}[*] Installing Go...${NC}"
    
    GO_DIR="/usr/local/go"
    GO_BIN="$GO_DIR/bin/go"
    
    # Check if already installed
    if command -v go &> /dev/null; then
        echo -e "${YELLOW}[!] Go already installed${NC}"
        go version
        return 0
    fi
    
    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            GO_ARCH="amd64"
            ;;
        aarch64)
            GO_ARCH="arm64"
            ;;
        *)
            echo -e "${RED}[!] Unsupported architecture: $ARCH${NC}"
            return 1
            ;;
    esac
    
    # Get latest Go version
    echo -e "${CYAN}[*] Fetching latest Go version...${NC}"
    GO_VERSION=$(curl -sL "https://go.dev/VERSION?m=text" | head -1)
    
    if [[ -z "$GO_VERSION" ]]; then
        GO_VERSION="go1.22.0"
        echo -e "${YELLOW}[!] Could not fetch latest version, using $GO_VERSION${NC}"
    fi
    
    GO_URL="https://go.dev/dl/${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
    TEMP_FILE="/tmp/go.tar.gz"
    
    echo -e "${CYAN}[*] Downloading $GO_VERSION for ${GO_ARCH}...${NC}"
    if ! curl -fSL "$GO_URL" -o "$TEMP_FILE"; then
        echo -e "${RED}[!] Failed to download Go${NC}"
        return 1
    fi
    
    # Remove old installation and extract (requires sudo)
    echo -e "${CYAN}[*] Installing Go to /usr/local/go (requires sudo)...${NC}"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "$TEMP_FILE"
    rm -f "$TEMP_FILE"
    
    # Add to PATH in .bashrc
    BASHRC="$HOME/.bashrc"
    if ! grep -q "/usr/local/go/bin" "$BASHRC" 2>/dev/null; then
        echo -e "${CYAN}[*] Adding Go to PATH in ~/.bashrc...${NC}"
        echo "" >> "$BASHRC"
        echo "# Go programming language" >> "$BASHRC"
        echo 'export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"' >> "$BASHRC"
    fi
    
    # Add to fish config if fish is installed
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    if command -v fish &> /dev/null; then
        mkdir -p "$(dirname "$FISH_CONFIG")"
        if ! grep -q "/usr/local/go/bin" "$FISH_CONFIG" 2>/dev/null; then
            echo -e "${CYAN}[*] Adding Go to PATH in fish config...${NC}"
            echo "" >> "$FISH_CONFIG"
            echo "# Go programming language" >> "$FISH_CONFIG"
            echo 'set -gx PATH /usr/local/go/bin $HOME/go/bin $PATH' >> "$FISH_CONFIG"
        fi
    fi
    
    # Create Go workspace directories
    mkdir -p "$HOME/go/"{bin,src,pkg}
    
    # Verify installation
    if [[ -x "$GO_BIN" ]]; then
        echo -e "${GREEN}[OK] Go installed successfully!${NC}"
        "$GO_BIN" version
        echo -e "${YELLOW}[!] Run 'source ~/.bashrc' or restart your terminal${NC}"
        echo -e "${CYAN}[*] Go workspace created at ~/go${NC}"
    else
        echo -e "${RED}[!] Installation failed${NC}"
        return 1
    fi
}

if [[ "$INSTALL_GO" == "true" ]]; then
    install_go
fi

# ===== HYPRPANEL =====
install_hyprpanel() {
    echo -e "\n${CYAN}[*] Installing HyprPanel...${NC}"
    
    HYPRPANEL_DIR="$HOME/.local/src/HyprPanel"
    LOCAL_BIN="$HOME/.local/bin"
    
    # Check if already installed
    if [[ -d "$HYPRPANEL_DIR" ]]; then
        echo -e "${YELLOW}[!] HyprPanel already exists at $HYPRPANEL_DIR${NC}"
        echo -e "${CYAN}[*] Updating HyprPanel...${NC}"
        cd "$HYPRPANEL_DIR"
        git pull
    else
        # Install dependencies based on distro
        echo -e "${CYAN}[*] Installing HyprPanel dependencies...${NC}"
        
        if [[ "$DISTRO" == "fedora" ]]; then
            # AGS v2 (aylurs-gtk-shell)
            if ! command -v ags &> /dev/null; then
                echo -e "${CYAN}[*] Installing AGS v2 via COPR...${NC}"
                sudo dnf copr enable -y aylur/ags
                sudo dnf install -y aylurs-gtk-shell2
            fi
            
            # Other dependencies
            sudo dnf install -y \
                libgtop2-devel \
                libpulse-devel \
                NetworkManager-libnm-devel \
                gtk3-devel \
                libsoup3-devel \
                power-profiles-daemon \
                gpu-screen-recorder \
                btop \
                bluez \
                bluez-tools \
                grimblast \
                brightnessctl \
                upower \
                gnome-bluetooth \
                dart-sass \
                wl-clipboard || true
                
        elif [[ "$DISTRO" == "arch" ]]; then
            # Install from AUR
            if command -v yay &> /dev/null; then
                yay -S --noconfirm aylurs-gtk-shell hyprpanel-git || true
            elif command -v paru &> /dev/null; then
                paru -S --noconfirm aylurs-gtk-shell hyprpanel-git || true
            else
                echo -e "${YELLOW}[!] Please install yay or paru for AUR packages${NC}"
                echo -e "${YELLOW}[!] Then run: yay -S aylurs-gtk-shell hyprpanel-git${NC}"
            fi
        fi
        
        # Clone HyprPanel
        echo -e "${CYAN}[*] Cloning HyprPanel...${NC}"
        mkdir -p "$(dirname "$HYPRPANEL_DIR")"
        git clone https://github.com/Jas-SinghFSU/HyprPanel.git "$HYPRPANEL_DIR"
    fi
    
    # Create local bin directory
    mkdir -p "$LOCAL_BIN"
    
    # Install wrapper script
    echo -e "${CYAN}[*] Installing hyprpanel wrapper script...${NC}"
    cp "$SCRIPT_DIR/hyprpanel/hyprpanel-wrapper" "$LOCAL_BIN/hyprpanel"
    chmod +x "$LOCAL_BIN/hyprpanel"
    
    # Install preset and theme scripts
    echo -e "${CYAN}[*] Installing hyprpanel-preset and hyprpanel-theme scripts...${NC}"
    ln -sf "$SCRIPT_DIR/hyprpanel/hyprpanel-preset" "$LOCAL_BIN/hyprpanel-preset"
    ln -sf "$SCRIPT_DIR/hyprpanel/hyprpanel-theme" "$LOCAL_BIN/hyprpanel-theme"
    chmod +x "$SCRIPT_DIR/hyprpanel/hyprpanel-preset"
    chmod +x "$SCRIPT_DIR/hyprpanel/hyprpanel-theme"
    
    # Install HyprPanel config
    echo -e "${CYAN}[*] Installing HyprPanel config...${NC}"
    mkdir -p "$CONFIG_DIR/hyprpanel"
    
    if [[ -f "$SCRIPT_DIR/hyprpanel/config/config.json" ]]; then
        install_config "$SCRIPT_DIR/hyprpanel/config/config.json" "$CONFIG_DIR/hyprpanel/config.json" "HyprPanel config"
    fi
    
    # Add ~/.local/bin to PATH if not already
    BASHRC="$HOME/.bashrc"
    if ! grep -q '\.local/bin' "$BASHRC" 2>/dev/null; then
        echo -e "${CYAN}[*] Adding ~/.local/bin to PATH...${NC}"
        echo '' >> "$BASHRC"
        echo '# Local binaries' >> "$BASHRC"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$BASHRC"
    fi
    
    # Fish config
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    if command -v fish &> /dev/null; then
        mkdir -p "$(dirname "$FISH_CONFIG")"
        if ! grep -q '\.local/bin' "$FISH_CONFIG" 2>/dev/null; then
            echo '' >> "$FISH_CONFIG"
            echo '# Local binaries' >> "$FISH_CONFIG"
            echo 'set -gx PATH $HOME/.local/bin $PATH' >> "$FISH_CONFIG"
        fi
    fi
    
    echo -e "${GREEN}[OK] HyprPanel installed successfully!${NC}"
    echo -e "${CYAN}[*] Available commands:${NC}"
    echo "    hyprpanel              - Run HyprPanel"
    echo "    hyprpanel-preset list  - List available presets"
    echo "    hyprpanel-preset <name> - Apply a preset"
    echo "    hyprpanel-theme list   - List available themes"
    echo "    hyprpanel-theme <name> - Apply a theme"
    echo -e "${YELLOW}[!] Make sure to update your hyprland.conf to autostart hyprpanel${NC}"
    echo -e "${YELLOW}[!] Replace: exec-once = waybar${NC}"
    echo -e "${YELLOW}[!] With:    exec-once = hyprpanel${NC}"
}

if [[ "$INSTALL_HYPRPANEL" == "true" ]]; then
    install_hyprpanel
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
echo ""
echo "  # netcoredbg (debugger) - Option 1: Automatic"
echo "  ./install.sh --install-netcoredbg"
echo ""
echo "  # netcoredbg - Option 2: Manual"
echo "  # 1. Download from: https://github.com/Samsung/netcoredbg/releases"
echo "  # 2. Extract:"
echo "  mkdir -p ~/.local/share/netcoredbg"
echo "  tar -xzf netcoredbg-linux-amd64.tar.gz -C ~/.local/share/netcoredbg"
echo "  # 3. Add to PATH (~/.bashrc):"
echo '  echo '\''export PATH="$HOME/.local/share/netcoredbg/netcoredbg:$PATH"'\'' >> ~/.bashrc'
echo "  source ~/.bashrc"
echo "  # 4. Verify:"
echo "  netcoredbg --version"

echo -e "\n${YELLOW}For Flutter development:${NC}"
echo "  # Option 1: Automatic (recommended)"
echo "  ./install.sh --install-flutter"
echo ""
echo "  # Option 2: Manual"
echo "  # Download from: https://flutter.dev/docs/get-started/install/linux"
echo "  # Extract to ~/.local/share/flutter"
echo "  # Add to PATH: export PATH=\"\$HOME/.local/share/flutter/bin:\$PATH\""
echo "  # Run: flutter doctor"

echo -e "\n${YELLOW}For Go development:${NC}"
echo "  # Option 1: Automatic (recommended)"
echo "  ./install.sh --install-go"
echo ""
echo "  # Option 2: Package manager"
echo "  sudo dnf install golang  # Fedora"
echo "  sudo pacman -S go        # Arch"

echo -e "\n${YELLOW}Install all dev tools at once:${NC}"
echo "  ./install.sh --install-dev-tools"

echo -e "\n${YELLOW}For HyprPanel (modern Waybar replacement):${NC}"
echo "  ./install.sh --install-hyprpanel"
echo ""
echo "  After installation, use:"
echo "    hyprpanel-theme list       - See available themes"
echo "    hyprpanel-theme <name>     - Apply a theme"
echo "    hyprpanel-preset list      - See available presets"
echo "    hyprpanel-preset <name>    - Apply a preset"
echo ""
echo "  Themes include: catppuccin-mocha, tokyo-night, nord, dracula,"
echo "                  rose-pine, gruvbox, cyberpunk, and glass variants"

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
echo "  Super+Return    = Terminal (Ghostty)"
echo "  Super+Space     = App launcher (Wofi)"
echo "  Super+Q         = Close window"
echo "  Super+HJKL      = Focus window"
echo "  Super+1-9       = Switch workspace"
echo "  Super+Shift+1-9 = Move to workspace"
echo "  Super+F         = Fullscreen"
echo "  Super+Ctrl+L    = Lock screen (Hyprlock)"
echo "  Print           = Screenshot (area)"
echo ""
