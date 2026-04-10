# AGENTS.md

## What this repo is
- Personal dotfiles repo, not a buildable app. There is no root package manifest, CI workflow, Makefile, or repo-wide test/lint task.
- Do not invent `npm`, `pnpm`, `cargo`, or generic test commands at repo root. Validation here is usually file-level review, not a build pipeline.

## Safety before you touch anything
- `install.sh` and `install.ps1` mutate the real machine (`$HOME`, shell defaults, PATH, cloned tools). Do **not** run them as a casual verification step.
- `bash/bashrc` ends with machine-specific exports, including local credential/project paths. Preserve those unless the user explicitly asks to sanitize local values.

## Directory boundaries
- Cross-platform/shared: `nvim/`, `bash/`, `fish/`, `starship/`, `wezterm.lua`, `kitty/`, `ghostty/`, `scripts/`.
- Linux/Wayland only: `hyprland/`, `hyprpanel/`, `waybar/`, `wofi/`, `dunst/`.
- Windows only: `glazewm/`, `yasb/`.

## Install behavior that changes how edits propagate
- Linux/macOS entrypoint: `./install.sh`; Windows entrypoint: `./install.ps1`.
- `install.sh` symlinks `bash/`, `fish/`, `starship/`, and `nvim/`, but copies terminal/WM configs (`wezterm.lua`, `kitty/`, `ghostty/`, `hyprland/`, `waybar/`, `wofi/`, `dunst/`). Repo edits only live-update the symlinked targets.
- `install.ps1` copies everything; Windows configs do not live-update from the repo.
- High-value `install.sh` flags: `--force`, `--skip-hyprland`, `--install-dev-tools`, `--install-hyprpanel`, `--install-shell`.
- `install.ps1` only supports `-Force`, `-SkipNeovim`, `-SkipWezterm`, `-SkipGlazeWM`, and `-SkipYASB`.
- `--install-shell` = Fish + Starship + set Fish as default shell.
- `install.ps1` also installs `gzip` if missing because the Windows Codeium setup depends on it.

## Repo-location assumptions
- Some files hardcode `~/dotfiles`: `fish/config.fish` adds `~/dotfiles/scripts` to PATH, and `hyprpanel/hyprpanel-wrapper` reads `$HOME/dotfiles/hyprpanel/config/config.json`.
- If the repo is moved, update those paths too.

## Linux panel gotchas
- The active Linux bar is **HyprPanel**, not Waybar: `hyprland/hyprland.conf` autostarts `~/.local/bin/hyprpanel`.
- `waybar/` still exists, but treat it as fallback/legacy unless the user says otherwise.
- Edit `hyprpanel/config/config.json` in the repo, not only `~/.config/hyprpanel/config.json`; the wrapper recopies the repo version on launch.
- `Super+Return` launches `ghostty` on Linux, not WezTerm.

## Neovim: use code as source of truth
- Real entrypoint is `nvim/init.lua -> lua/config/lazy.lua`; behavior lives in `nvim/lua/plugins/*.lua`. The READMEs lag the code.
- Format touched Lua with `stylua` using `nvim/stylua.toml` (2 spaces, width 120) if available.
- `.NET` uses **Roslyn**, not OmniSharp: `roslyn.lua` disables OmniSharp, `mason.lua` adds `Crashdummyy/mason-registry`, and the current setup expects .NET 10.
- OpenCode is launched via hardcoded `~/.opencode/bin/opencode` in `nvim/lua/config/keymaps.lua` because Snacks terminals may not inherit a full PATH.
- Terminal and dashboard UI use **Snacks.nvim**, not ToggleTerm/Alpha.
- Actual key prefixes are `<leader>N` (.NET), `<leader>F` (Flutter), `<leader>G` (Go), `<leader>T` (TypeScript), `<leader>d` (debug), and `<leader>o` (OpenCode). Do not trust README keymap tables without checking plugin files.
- `F5` runs `DapSmart`, which detects `pubspec.yaml`, `go.mod`, `package.json`, then `*.csproj` / `*.sln` to choose Flutter/Go/Node/.NET debug flow.
- `.NET` DAP auto-searches DLLs under `Apps/*/bin/Debug/net*` first, then local `bin/Debug/net*`, then falls back to manual DLL selection.

## Shell behavior
- Fish is the primary shell. `bash/bashrc` exists mainly for compatibility and will `exec fish` in interactive sessions if Fish is installed.
- Neovim terminal keymaps still launch `bash` explicitly.
- Put new machine-local Fish tweaks in `~/.config/fish/local.fish`; the repo already sources it.

## Docs drift to expect
- `README.md` and `nvim/README.md` are useful overviews, but stale for operational details like key prefixes, active Linux bar, version requirements, and some feature counts.
- When docs conflict with config/scripts, trust the executable sources.
