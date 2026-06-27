local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Open WSL2 Ubuntu by default
config.default_prog = { 'wsl.exe', '--distribution', 'Ubuntu' }

-- Font - Kun uses a nerd font for icons in neovim/tmux
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 14.0

-- Window appearance
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Colors - dark theme
config.color_scheme = 'Tokyo Night'

-- Window decorations
config.window_decorations = 'RESIZE'

-- Scrollback
config.scrollback_lines = 10000

-- Key bindings
config.keys = {
  -- New tab
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  -- Split pane horizontally
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Split pane vertically
  { key = 'e', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

return config
