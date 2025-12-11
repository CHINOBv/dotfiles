-- ~/.wezterm.lua
-- Configuración de Wezterm: UI Moderna con Catppuccin Mocha

local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ===================================================================
-- COLORES CATPPUCCIN MOCHA
-- ===================================================================
local colors = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

-- ===================================================================
-- RENDIMIENTO Y SHELL
-- ===================================================================
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.animation_fps = 60

-- Shell por defecto (detectar OS)
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

if is_windows then
  config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-NoLogo" }
elseif is_linux then
  config.default_prog = { "/usr/bin/fish" }
  -- Fallback a bash si fish no está instalado
  if not io.open("/usr/bin/fish", "r") then
    config.default_prog = { "/bin/bash" }
  end
end

-- Wayland en Linux
if is_linux then
  config.enable_wayland = true
end

-- ===================================================================
-- FUENTE Y TIPOGRAFÍA
-- ===================================================================
config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "Medium" },
  { family = "FiraCode Nerd Font", weight = "Regular" },
  { family = "Cascadia Code", weight = "Regular" },
})
config.font_size = 11.0
config.line_height = 1.1
config.cell_width = 1.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1", "zero", "ss01", "ss02" }

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ===================================================================
-- VENTANA Y FONDO
-- ===================================================================
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.win32_system_backdrop = "Acrylic" -- Windows 11 blur effect

config.window_padding = {
  left = 15,
  right = 15,
  top = 10,
  bottom = 10,
}

-- Sin bordes de ventana, solo resize
config.window_decorations = "RESIZE"

-- Oscurecer paneles inactivos
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.65,
}

-- ===================================================================
-- ESQUEMA DE COLORES
-- ===================================================================
config.color_scheme = "Catppuccin Mocha"

config.colors = {
  cursor_bg = colors.rosewater,
  cursor_fg = colors.crust,
  cursor_border = colors.rosewater,
  selection_bg = colors.surface2,
  selection_fg = colors.text,
  split = colors.surface0,

  tab_bar = {
    background = colors.crust,
    active_tab = {
      bg_color = colors.mauve,
      fg_color = colors.crust,
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = colors.mantle,
      fg_color = colors.subtext0,
    },
    inactive_tab_hover = {
      bg_color = colors.surface0,
      fg_color = colors.text,
    },
    new_tab = {
      bg_color = colors.mantle,
      fg_color = colors.subtext0,
    },
    new_tab_hover = {
      bg_color = colors.surface0,
      fg_color = colors.rosewater,
    },
  },
}

-- ===================================================================
-- TAB BAR PERSONALIZADA
-- ===================================================================
config.use_fancy_tab_bar = false -- Usar tab bar custom
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

-- Iconos para diferentes procesos
local process_icons = {
  ["pwsh"] = wezterm.nerdfonts.md_powershell,
  ["powershell"] = wezterm.nerdfonts.md_powershell,
  ["cmd"] = wezterm.nerdfonts.md_console,
  ["bash"] = wezterm.nerdfonts.dev_terminal,
  ["zsh"] = wezterm.nerdfonts.dev_terminal,
  ["fish"] = wezterm.nerdfonts.md_fish,
  ["nu"] = wezterm.nerdfonts.md_greater_than,
  ["nvim"] = wezterm.nerdfonts.custom_neovim,
  ["vim"] = wezterm.nerdfonts.dev_vim,
  ["node"] = wezterm.nerdfonts.md_nodejs,
  ["python"] = wezterm.nerdfonts.dev_python,
  ["python3"] = wezterm.nerdfonts.dev_python,
  ["go"] = wezterm.nerdfonts.md_language_go,
  ["dotnet"] = wezterm.nerdfonts.md_dot_net,
  ["git"] = wezterm.nerdfonts.dev_git,
  ["lazygit"] = wezterm.nerdfonts.dev_git,
  ["docker"] = wezterm.nerdfonts.dev_docker,
  ["kubectl"] = wezterm.nerdfonts.md_kubernetes,
  ["flutter"] = wezterm.nerdfonts.md_flutter,
  ["dart"] = wezterm.nerdfonts.dev_dart,
  ["cargo"] = wezterm.nerdfonts.dev_rust,
  ["rustc"] = wezterm.nerdfonts.dev_rust,
  ["make"] = wezterm.nerdfonts.seti_makefile,
  ["ssh"] = wezterm.nerdfonts.md_ssh,
  ["top"] = wezterm.nerdfonts.md_chart_areaspline,
  ["htop"] = wezterm.nerdfonts.md_chart_areaspline,
  ["btop"] = wezterm.nerdfonts.md_chart_areaspline,
}

local function get_process_icon(pane)
  local process_name = pane:get_foreground_process_name()
  if process_name then
    process_name = string.gsub(process_name, "(.*[/\\])(.*)", "%2")
    process_name = string.gsub(process_name, "%.exe$", "")
  end
  return process_icons[process_name] or wezterm.nerdfonts.cod_terminal
end

local function get_current_working_dir(pane)
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local cwd = cwd_uri.file_path
    -- Acortar el path
    cwd = string.gsub(cwd, wezterm.home_dir, "~")
    -- Solo mostrar últimos 2 directorios
    local parts = {}
    for part in string.gmatch(cwd, "[^/\\]+") do
      table.insert(parts, part)
    end
    if #parts > 2 then
      cwd = "…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
    end
    return cwd
  end
  return ""
end

-- Formato de tabs con powerline
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local icon = get_process_icon(pane)
  local cwd = get_current_working_dir(pane)
  local index = tab.tab_index + 1

  local title = string.format(" %s %s %s ", index, icon, cwd)

  -- Truncar si es muy largo
  if #title > max_width - 2 then
    title = wezterm.truncate_right(title, max_width - 5) .. "… "
  end

  local bg = colors.mantle
  local fg = colors.subtext0

  if tab.is_active then
    bg = colors.mauve
    fg = colors.crust
  elseif hover then
    bg = colors.surface0
    fg = colors.text
  end

  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = title },
  }
end)

-- ===================================================================
-- STATUS BAR (DERECHA)
-- ===================================================================
wezterm.on("update-right-status", function(window, pane)
  local cells = {}

  -- Indicador de modo (LEADER activo)
  local name = window:active_key_table()
  if name then
    table.insert(cells, { Foreground = { Color = colors.peach } })
    table.insert(cells, { Text = " " .. wezterm.nerdfonts.md_rocket_launch .. " " .. string.upper(name) .. " " })
  end

  -- Indicador de LEADER key pressed
  if window:leader_is_active() then
    table.insert(cells, { Foreground = { Color = colors.green } })
    table.insert(cells, { Text = " " .. wezterm.nerdfonts.md_keyboard .. " LEADER " })
  end

  -- Batería (si aplica)
  local battery = wezterm.battery_info()
  if battery and #battery > 0 then
    local charge = battery[1].state_of_charge * 100
    local battery_icon = wezterm.nerdfonts.md_battery
    if charge <= 20 then
      battery_icon = wezterm.nerdfonts.md_battery_20
    elseif charge <= 50 then
      battery_icon = wezterm.nerdfonts.md_battery_50
    elseif charge <= 80 then
      battery_icon = wezterm.nerdfonts.md_battery_80
    end
    table.insert(cells, { Foreground = { Color = colors.yellow } })
    table.insert(cells, { Text = string.format(" %s %.0f%% ", battery_icon, charge) })
  end

  -- Hostname
  table.insert(cells, { Foreground = { Color = colors.blue } })
  table.insert(cells, { Text = " " .. wezterm.nerdfonts.md_laptop .. " " .. wezterm.hostname() .. " " })

  -- Fecha y hora
  table.insert(cells, { Foreground = { Color = colors.lavender } })
  table.insert(cells, { Text = " " .. wezterm.nerdfonts.md_calendar_clock .. " " .. wezterm.strftime("%a %d %b") .. " " })

  table.insert(cells, { Foreground = { Color = colors.rosewater } })
  table.insert(cells, { Text = wezterm.nerdfonts.md_clock_outline .. " " .. wezterm.strftime("%H:%M") .. " " })

  window:set_right_status(wezterm.format(cells))
end)

-- Status izquierdo (workspace)
wezterm.on("update-status", function(window, pane)
  local workspace = window:active_workspace()
  local cells = {
    { Foreground = { Color = colors.crust } },
    { Background = { Color = colors.blue } },
    { Text = " " .. wezterm.nerdfonts.cod_window .. " " .. workspace .. " " },
    { Background = { Color = colors.crust } },
    { Foreground = { Color = colors.blue } },
    { Text = "" },
  }
  window:set_left_status(wezterm.format(cells))
end)

-- ===================================================================
-- ATAJOS DE TECLADO
-- ===================================================================
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
  -- Desactivar Alt+Enter para que pase a la aplicación
  { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },

  -- Splits
  { key = "-", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Cerrar panel
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

  -- Nueva pestaña
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

  -- Navegación entre paneles (Vim style)
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

  -- Navegación rápida con Alt
  { key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

  -- Resize paneles
  { key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

  -- Navegación entre pestañas
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

  -- Mover tabs
  { key = "<", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
  { key = ">", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

  -- Modo copia
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

  -- Maximizar panel
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "m", mods = "LEADER", action = act.TogglePaneZoomState },

  -- Fullscreen
  { key = "F11", mods = "NONE", action = act.ToggleFullScreen },

  -- Command palette
  { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },

  -- Buscar
  { key = "f", mods = "CTRL|SHIFT", action = act.Search({ CaseSensitiveString = "" }) },

  -- Recargar configuración
  { key = "r", mods = "LEADER", action = act.ReloadConfiguration },

  -- Workspaces
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "s", mods = "LEADER", action = act.PromptInputLine({
    description = "Enter new workspace name:",
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
      end
    end),
  }) },
}

-- Atajos para ir a pestañas 1-9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
  table.insert(config.keys, {
    key = tostring(i),
    mods = "ALT",
    action = act.ActivateTab(i - 1),
  })
end

-- Modo copia estilo Vim
config.key_tables = {
  copy_mode = {
    { key = "c", mods = "CTRL", action = act.CopyMode("Close") },
    { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
    { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

    { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
    { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },

    { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
    { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },

    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

    { key = "y", mods = "NONE", action = act.Multiple({
      { CopyTo = "ClipboardAndPrimarySelection" },
      { CopyMode = "Close" },
    }) },

    { key = "/", mods = "NONE", action = act.Search({ CaseSensitiveString = "" }) },
    { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "N", mods = "SHIFT", action = act.CopyMode("PriorMatch") },
  },

  search_mode = {
    { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
    { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
    { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
  },
}

-- ===================================================================
-- MOUSE
-- ===================================================================
config.mouse_bindings = {
  -- Click derecho pega
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
  -- Ctrl+Click abre links
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
}

-- ===================================================================
-- OTRAS CONFIGURACIONES
-- ===================================================================
config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = "CursorColor",
}
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.check_for_updates = false
config.show_update_window = false

-- Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Quick select (Ctrl+Shift+Space)
config.quick_select_patterns = {
  -- Git hashes
  "[0-9a-f]{7,40}",
  -- URLs
  "https?://\\S+",
  -- File paths
  "[\\w\\-\\.]+\\.[a-z]+",
}

return config
