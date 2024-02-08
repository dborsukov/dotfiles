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
      lualine_x = {
        'diagnostics',
        {
          'location',
          padding = 0,
        },
        {
          'fileformat',
          symbols = {
            unix = 'unix',
            dos = 'dos',
            mac = 'mac',
          },
        },
        {
          'filetype',
          padding = {
            left = 0,
            right = 1,
          },
          icon = { align = 'left' },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
