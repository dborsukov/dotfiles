require("lsp_signature").setup({
    bind = true,
    hint_enable = false,
    handler_opts = {
        border = "rounded"
    }
})

require("inc_rename").setup {
    input_buffer_type = "dressing",
    preview_empty_name = true,
}

local cmp = require("cmp")

cmp.setup {
    enabled = function()
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-f>'] = cmp.mapping.scroll_docs(2),
        ['<C-d>'] = cmp.mapping.scroll_docs( -2),
        ['<C-a>'] = cmp.mapping.abort(),
        ['<tab>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    },
    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            menu = ({
                nvim_lua = "[Lua]",
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                latex_symbols = "[Latex]",
            })
        }),
    }
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local handlers = require("nvim-autopairs.completion.handlers")

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {
            ["*"] = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers["*"]
                }
            },
        }
    })
)
