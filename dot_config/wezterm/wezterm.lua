local wezterm = require('wezterm')
local config = wezterm.config_builder()

local font_with_fallback = wezterm.font_with_fallback({
  'IosevkaTerm NF',
  'Ubuntu Mono',
  'monospace',
})

config.font_size = 13
config.font = font_with_fallback

config.window_decorations = 'RESIZE'

config.window_frame = {
  border_left_width = '2px',
  border_right_width = '2px',
  border_bottom_height = '2px',
  border_top_height = '2px',
  border_left_color = '#3c3836',
  border_right_color = '#3c3836',
  border_bottom_color = '#3c3836',
  border_top_color = '#3c3836',
}

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

local padding = 5

config.window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
