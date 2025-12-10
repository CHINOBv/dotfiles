-- ~/.wezterm.lua
-- Configuración de Wezterm v3: Rendimiento y Estética Superior

local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ===================================================================
-- RENDIMIENTO Y SHELL
-- ===================================================================

-- Usamos el renderizador por defecto (WebGpu) que suele ser el más rápido.
-- La combinación con un fondo opaco debería evitar los artefactos visuales.
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- Shell por defecto
config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-NoLogo' }

-- ===================================================================
-- APARIENCIA Y UI
-- ===================================================================

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular' })
config.font_size = 11.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Cursor sólido y sin parpadeo para una sensación de mayor respuesta
config.default_cursor_style = 'SteadyBlock'

-- Fondo 100% opaco
config.window_background_opacity = 0.92

-- Padding de la ventana
config.window_padding = {
  left = 10,
  right = 10,
  top = 15,
  bottom = 5,
}

-- Oscurecer paneles inactivos para mejorar el foco
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}

-- Desactivar la barra de scroll
config.enable_scroll_bar = false

-- ===================================================================
-- BARRA DE PESTAÑAS (UI MEJORADA)
-- ===================================================================

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false -- Pestañas arriba

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  -- Icono para la pestaña activa
  local icon = ' 󰓩 ' -- nf-md-tab_active

  if not tab.is_active then
    -- Icono para pestañas inactivas
    icon = ' 󰓨 ' -- nf-md-tab
  end

  -- Acortar títulos largos
  if #title > 25 then
    title = wezterm.truncate_right(title, 25)
  end

  return {
    { Text = icon .. title .. ' ' },
  }
end)

config.colors = {
  tab_bar = {
    background = '#11111b', -- Base de Catppuccin
    active_tab = {
      bg_color = '#89b4fa', -- Azul
      fg_color = '#11111b',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#1e1e2e', -- Surface0
      fg_color = '#cdd6f4', -- Text
    },
    inactive_tab_hover = {
      bg_color = '#313244', -- Surface1
      fg_color = '#cdd6f4',
    },
    new_tab = {
      bg_color = '#1e1e2e',
      fg_color = '#cdd6f4',
    },
    new_tab_hover = {
      bg_color = '#45475a', -- Surface2
      fg_color = '#f5e0dc', -- Rosewater
    },
  }
}

-- ===================================================================
-- BARRA DE TÍTULO Y STATUS
-- ===================================================================

config.window_decorations = 'RESIZE'

wezterm.on('update-right-status', function(window, pane)
  local elements = {}

  -- Modo líder: 🚀
  if window:active_key_table() then
    table.insert(elements, '🚀')
  end

  -- Reloj
  table.insert(elements, wezterm.strftime ' %H:%M ')
  window:set_right_status(wezterm.format(elements))
end)


-- ===================================================================
-- ATAJOS DE TECLADO
-- ===================================================================

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Desactivar Alt+Enter (fullscreen) para que pase a la aplicación
  { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },

  -- Splits (Vertical es más común para código, así que lo hacemos más simple)
  { key = '-', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '|', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Cerrar panel
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

  -- Nueva pestaña
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

  -- Navegación entre paneles (Vim)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- Navegación entre pestañas
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

  -- Modo copia
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

  -- Maximizar panel
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  
  -- Recargar configuración
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },
}

-- Atajos para ir a pestañas 1-9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  copy_mode = {
    { key = 'y', mods = 'NONE', action = act.CopyTo 'ClipboardAndPrimarySelection' },
    { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
  },
}

-- ===================================================================
-- OTRAS CONFIGURACIONES
-- ===================================================================

config.automatically_reload_config = true
config.audible_bell = 'Disabled'
config.window_close_confirmation = 'NeverPrompt'

return config
