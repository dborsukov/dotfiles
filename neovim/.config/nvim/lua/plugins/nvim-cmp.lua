return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet engine
    'dcampos/nvim-snippy',
    -- Pictograms
    'onsails/lspkind.nvim',
    -- Source: LSP
    'hrsh7th/cmp-nvim-lsp',
    -- Source: path
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')

    vim.o.completeopt = 'menuone,noselect'

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      }),
      preselect = cmp.PreselectMode.None,
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
      },
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
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
