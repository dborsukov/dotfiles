return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox-material',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        { 'diff', padding = { left = 0, right = 1 } },
      },
      lualine_c = {
        'filename',
        {
          'diagnostics',
          padding = { left = 0, right = 1 },
          symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
        },
      },
      lualine_x = {
        { 'fileformat', symbols = { unix = 'unix', dos = 'dos', mac = 'mac' } },
        'encoding',
        { 'filetype', colored = false, icon = { align = 'right' } },
      },
      lualine_y = { 'location' },
      lualine_z = {},
    },
    extensions = { 'oil' },
  },
}
