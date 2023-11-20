-- Packages improving Neovim LSP capabilites
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP installer/manager
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    -- Additional Lua configuration for Neovim APIs and plugins
    'folke/neodev.nvim',
  },
}
