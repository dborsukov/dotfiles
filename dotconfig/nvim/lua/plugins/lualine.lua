-- Just a good statusline
return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = 'base16',
      globalstatus = true,
      icons_enabled = true,
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'filename' },
      lualine_c = { 'branch', 'diff' },
      lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
