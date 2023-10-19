return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({})
      local mlsp = require("mason-lspconfig")

      mlsp.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "bashls",
          "volar",
          "eslint",
        },
      })

      require("user.plugins.lsp.visuals")

      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local on_attach = function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>la", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<space>lf", vim.lsp.buf.format, bufopts)
        vim.keymap.set("n", "<space>lj", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "<space>lk", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      end

      local lspconfig = require("lspconfig")

      lspconfig["dartls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          dart = {
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
              vim.fn.expand("$HOME/.pub-cache/"),
              vim.fn.expand("/opt/homebrew/"),
              vim.fn.expand("$HOME/.local/share/flutter/"),
            },
          },
        },
      })

      mlsp.setup_handlers({
        -- Default handler
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        -- Dedicated handlers
        ["lua_ls"] = function(_)
          lspconfig["lua_ls"].setup({
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
                  enable = false,
                },
              },
            },
          })
        end,
        ["volar"] = function(_)
          lspconfig["volar"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
              "typescript",
              "javascript",
              "javascriptreact",
              "typescriptreact",
              "vue",
              "json",
            },
          })
        end,
      })
    end,
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.black,
          nls.builtins.formatting.prettier,
        },
      }
    end,
  },
}
