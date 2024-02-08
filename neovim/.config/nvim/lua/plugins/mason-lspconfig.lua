-- Installs language servers automatically
-- Also helps to configure them in a neat way
return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
  },
}
