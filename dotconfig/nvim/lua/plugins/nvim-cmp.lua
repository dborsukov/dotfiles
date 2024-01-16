-- Autocomplete
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet engine
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
    -- Pictograms
    'onsails/lspkind.nvim',
    -- Source: LSP
    'hrsh7th/cmp-nvim-lsp',
    -- Source: path
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          n = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol_text',
        }),
      },
    })
  end,
}
