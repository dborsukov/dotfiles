require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "bashls",
        "volar",
        "eslint",
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "<space>lj", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<space>lk", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>la", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>lf", vim.lsp.buf.format, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
end

require("mason-lspconfig").setup_handlers({
    -- Default handler
    function(server_name)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    -- Dedicated handlers
    ["lua_ls"] = function(_)
        require("lspconfig")["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim", "use" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                },
            },
        })
    end,
    ["volar"] = function(_)
        require("lspconfig")["volar"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        })
    end,
})
