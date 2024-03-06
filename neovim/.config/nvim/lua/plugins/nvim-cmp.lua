return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet engine
    'dcampos/nvim-snippy',
    -- Pictograms
    'onsails/lspkind.nvim',
    -- Sources
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup({
      completion = { completeopt = 'menu,menuone,noinsert' },
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
        end,
      },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol_text',
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete({}),
      }),
    })
  end,
}
