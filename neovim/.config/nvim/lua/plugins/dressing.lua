-- Improves Neovim UIs through 'vim.ui' api
return {
  'stevearc/dressing.nvim',
  opts = {
    select = {
      backend = { 'telescope' },
      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = nil,
    },
  },
}
