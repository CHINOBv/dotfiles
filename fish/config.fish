# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                           Fish Shell Config                               ║
# ║                        github.com/CHINOBv/dotfiles                        ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# ══════════════════════════════════════════════════════════════════════════════
# ENVIRONMENT VARIABLES
# ══════════════════════════════════════════════════════════════════════════════

# XDG Base Directories
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Locale
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# ══════════════════════════════════════════════════════════════════════════════
# PATH
# ══════════════════════════════════════════════════════════════════════════════

# Local binaries
fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/bin

# Go
set -gx GOPATH $HOME/go
fish_add_path -g /usr/local/go/bin
fish_add_path -g $GOPATH/bin

# Rust/Cargo
fish_add_path -g $HOME/.cargo/bin

# Node.js (nvm alternative - fnm)
if command -q fnm
    fnm env --use-on-cd --shell fish | source
end

# .NET
set -gx DOTNET_ROOT /usr/lib64/dotnet
fish_add_path -g $DOTNET_ROOT
fish_add_path -g $HOME/.dotnet/tools

# netcoredbg (.NET debugger)
fish_add_path -g $HOME/.local/share/netcoredbg/netcoredbg

# Flutter
fish_add_path -g $HOME/.local/share/flutter/bin

# OpenCode
fish_add_path -g $HOME/.opencode/bin

# Bun
set -gx BUN_INSTALL $HOME/.bun
fish_add_path -g $BUN_INSTALL/bin

# JetBrains Toolbox
fish_add_path -g $HOME/.local/share/JetBrains/Toolbox/scripts

# NVM (Node Version Manager) - use nvm.fish plugin or fnm instead
# If using nvm.fish plugin, it handles this automatically
# For manual nvm, see: https://github.com/jorgebucaran/nvm.fish
set -gx NVM_DIR $HOME/.nvm

# ══════════════════════════════════════════════════════════════════════════════
# COLORS & THEME
# ══════════════════════════════════════════════════════════════════════════════

# Catppuccin Mocha colors for Fish
set -g fish_color_normal cdd6f4
set -g fish_color_command 89b4fa
set -g fish_color_keyword cba6f7
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_end fab387
set -g fish_color_error f38ba8
set -g fish_color_param f2cdcd
set -g fish_color_comment 6c7086
set -g fish_color_selection --background=45475a
set -g fish_color_search_match --background=45475a
set -g fish_color_operator f5c2e7
set -g fish_color_escape eba0ac
set -g fish_color_autosuggestion 6c7086
set -g fish_color_cancel f38ba8
set -g fish_color_cwd f9e2af
set -g fish_color_user 94e2d5
set -g fish_color_host 89b4fa
set -g fish_color_host_remote a6e3a1
set -g fish_color_status f38ba8

# Pager colors
set -g fish_pager_color_progress 6c7086
set -g fish_pager_color_prefix f5c2e7
set -g fish_pager_color_completion cdd6f4
set -g fish_pager_color_description 6c7086
set -g fish_pager_color_selected_background --background=45475a

# ══════════════════════════════════════════════════════════════════════════════
# SHELL OPTIONS
# ══════════════════════════════════════════════════════════════════════════════

# Disable greeting
set -g fish_greeting

# Vi mode (optional - uncomment if you want vi keybindings)
# fish_vi_key_bindings

# ══════════════════════════════════════════════════════════════════════════════
# ABBREVIATIONS (like aliases but expand when you press space)
# ══════════════════════════════════════════════════════════════════════════════

# Navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a ..... "cd ../../../.."

# ls with eza (modern ls replacement)
if command -q eza
    abbr -a ls "eza --icons"
    abbr -a ll "eza -la --icons --git"
    abbr -a la "eza -a --icons"
    abbr -a lt "eza --tree --icons --level=2"
    abbr -a lta "eza --tree --icons -a --level=2"
else
    abbr -a ll "ls -la"
    abbr -a la "ls -a"
end

# Git
abbr -a g "git"
abbr -a ga "git add"
abbr -a gaa "git add --all"
abbr -a gc "git commit -m"
abbr -a gca "git commit -am"
abbr -a gcl "git clone"
abbr -a gco "git checkout"
abbr -a gcb "git checkout -b"
abbr -a gd "git diff"
abbr -a gds "git diff --staged"
abbr -a gf "git fetch"
abbr -a gl "git log --oneline --graph"
abbr -a gla "git log --oneline --graph --all"
abbr -a gp "git push"
abbr -a gpu "git push -u origin HEAD"
abbr -a gpl "git pull"
abbr -a gr "git remote -v"
abbr -a gs "git status -sb"
abbr -a gst "git stash"
abbr -a gstp "git stash pop"
abbr -a gm "git merge"
abbr -a grb "git rebase"

# Docker
abbr -a d "docker"
abbr -a dc "docker compose"
abbr -a dcu "docker compose up -d"
abbr -a dcd "docker compose down"
abbr -a dcl "docker compose logs -f"
abbr -a dps "docker ps"
abbr -a dpsa "docker ps -a"
abbr -a di "docker images"
abbr -a drm "docker rm"
abbr -a drmi "docker rmi"

# Kubernetes
abbr -a k "kubectl"
abbr -a kgp "kubectl get pods"
abbr -a kgs "kubectl get services"
abbr -a kgd "kubectl get deployments"
abbr -a kl "kubectl logs -f"
abbr -a ke "kubectl exec -it"
abbr -a kd "kubectl describe"

# .NET
abbr -a dn "dotnet"
abbr -a dnr "dotnet run"
abbr -a dnb "dotnet build"
abbr -a dnt "dotnet test"
abbr -a dnw "dotnet watch"
abbr -a dnwr "dotnet watch run"

# Editors
abbr -a v "nvim"
abbr -a vim "nvim"
abbr -a c "code"

# System
abbr -a ports "sudo lsof -i -P -n | grep LISTEN"
abbr -a myip "curl -s ifconfig.me"
abbr -a df "df -h"
abbr -a du "du -h"
abbr -a free "free -h"
abbr -a top "btop"

# Fedora specific
abbr -a dnfi "sudo dnf install"
abbr -a dnfu "sudo dnf upgrade"
abbr -a dnfs "dnf search"
abbr -a dnfr "sudo dnf remove"

# ══════════════════════════════════════════════════════════════════════════════
# KEY BINDINGS
# ══════════════════════════════════════════════════════════════════════════════

# Ctrl+f to accept autosuggestion
bind \cf forward-char

# Ctrl+e to edit command in editor
bind \ce edit_command_buffer

# ══════════════════════════════════════════════════════════════════════════════
# INTEGRATIONS
# ══════════════════════════════════════════════════════════════════════════════

# Starship prompt
if command -q starship
    starship init fish | source
end

# Zoxide (smart cd)
if command -q zoxide
    zoxide init fish | source
end

# fzf key bindings
if command -q fzf
    fzf --fish | source
end

# direnv
if command -q direnv
    direnv hook fish | source
end

# ══════════════════════════════════════════════════════════════════════════════
# LOCAL CONFIG (machine-specific, not in git)
# ══════════════════════════════════════════════════════════════════════════════

if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
fish_add_path ~/dotfiles/scripts
