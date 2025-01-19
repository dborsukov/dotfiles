local wezterm = require('wezterm')
local config = wezterm.config_builder()

local font_with_fallback = wezterm.font_with_fallback({
  'DepartureMono Nerd Font',
  'IosevkaTerm NF',
  'Ubuntu Mono',
  'monospace',
})

config.font_size = 13
config.font = font_with_fallback

config.color_scheme = 'Gruvbox Material (Gogh)'
config.colors = {
  background = '#1d2021',
  tab_bar = {
    active_tab = {
      intensity = 'Bold',
      fg_color = '#3c3836',
      bg_color = '#8ec07c',
    },
  },
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
