-- Packages providing autocomplete from different sources
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Pictograms for completion categories
    'onsails/lspkind.nvim',
    -- Snippet engine
    'L3MON4D3/LuaSnip',
    -- Collection of snippets
    'rafamadriz/friendly-snippets',
    -- Source: LSP
    'hrsh7th/cmp-nvim-lsp',
    -- Source: snippets
    'saadparwaiz1/cmp_luasnip',
    -- Source: path
    'hrsh7th/cmp-path',
  },
}
