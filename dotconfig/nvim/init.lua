-- vim: ts=2 sts=2 sw=2 et
---@diagnostic disable: missing-fields

-- This should always be done before Lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Bootstrapping Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tutor',
        'tohtml',
        'tarPlugin',
        'zipPlugin',
        'netrwPlugin',
      },
    },
  },
})

-- Enable 24-bit colors
vim.o.termguicolors = true
-- Enable mouse
vim.o.mouse = 'a'
-- No line wrapping
vim.wo.wrap = false
-- Sane scrolloff
vim.o.scrolloff = 7
-- Enable line numbers
vim.wo.number = true
-- Save undo history
vim.bo.undofile = true
-- Who uses swap?
vim.o.swapfile = false
-- Disable search highlight
vim.o.hlsearch = false
-- No tabs, please
vim.bo.expandtab = true
-- Default colorcolumn
vim.wo.colorcolumn = '100'
-- Case-insensitive searching unless \C or capital in search
vim.o.smartcase = true
vim.o.ignorecase = true
-- Sign column always on
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Treesitter powered folding
vim.wo.foldenable = false
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Fast ESC
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
-- Neotree
vim.keymap.set('n', '<tab>', '<cmd>Neotree toggle<cr>', { silent = true })
-- Bufferline
vim.keymap.set({ 'n', 'i', 'v' }, '<C-l>', '<cmd>BufferLineCycleNext<cr>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-h>', '<cmd>BufferLineCyclePrev<cr>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-q>', '<cmd>bd<cr>', { silent = true })
-- Search
vim.keymap.set('n', '<leader>f/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'Text in buffer' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Text in CWD' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fC', require('telescope.builtin').command_history, { desc = 'Recent commands' })
vim.keymap.set('n', '<leader>fa', require('telescope.builtin').autocommands, { desc = 'Autocommands' })

-- Register existing key chains
require('which-key').register({
  ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = 'More LSP', _ = 'which_key_ignore' },
})

-- Native fzf written in C, much faster
require('telescope').load_extension('fzf')

-- LSP config
local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    local format_command = function()
      vim.lsp.buf.format({
        async = false,
        -- never request 'tsserver' for formatting
        filter = function(c)
          return c.name ~= 'tsserver'
        end,
      })
    end
    vim.keymap.set('n', '<leader>f', format_command, { buffer = bufnr, desc = 'LSP: Format' })
    -- format on save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = format_command,
    })
  end

  if client.supports_method('textDocument/hover') then
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover Documentation' })
  end

  if client.supports_method('textDocument/signatureHelp') then
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP: Signature Documentation' })
  end

  if client.supports_method('textDocument/publishDiagnostics') then
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP: Next diagnostic' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP: Prev diagnostic' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { buffer = bufnr, desc = 'LSP: Float diagnostic' })
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics, { buffer = bufnr, desc = 'LSP: List diagnostics' })
  end

  if client.supports_method('textDocument/rename') then
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename' })
  end

  if client.supports_method('textDocument/definition') then
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { buffer = bufnr, desc = 'LSP: Goto Definition' })
  end

  if client.supports_method('textDocument/implementation') then
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { buffer = bufnr, desc = 'LSP: Goto Implementations' })
  end

  if client.supports_method('textDocument/references') then
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'LSP: Goto References' })
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
-- Configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- These configs are also accessible with ':help lspconfig-all'
local servers = {
  bashls = {},
  clangd = {},
  lua_ls = {
    Lua = {
      format = { enable = false },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        enable = true,
        globals = {
          'vim',
        },
      },
    },
  },
  svelte = {},
  pyright = {},
  tailwindcss = {
    filetypes = {
      'css',
      'html',
      'javascript',
      'javascript.jsx',
      'javascriptreact',
      'postcss',
      'sass',
      'scss',
      'svelte',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
    },
  },
  tsserver = {
    filetypes = {
      'javascript',
      'javascript.jsx',
      'javascriptreact',
      'svelte',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
    },
  },
}

-- Rust LSP with goodies
require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

-- Additional tools injected through "dummy" language server
local null_ls = require('null-ls')
null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- Shell
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.shellcheck,
    -- Python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- Prettier
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'css',
        'graphql',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'jsonc',
        'less',
        'scss',
        'svelte',
        'typescript',
        'typescriptreact',
        'vue',
        'yaml',
      },
    }),
    -- Lua
    null_ls.builtins.formatting.stylua,
  },
})

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

-- Highlight line/region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  pattern = { 'man', 'help', 'lspinfo', 'startuptime', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Wrap lines and check for spelling in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TextFiletypeWrapAndSpelling', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Automatically change CWD when entering buffer
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('MyAutoRoot', { clear = true }),
  callback = function()
    local root_names = {
      '.git',
      'Makefile',
      'package.json',
      'Cargo.toml',
    }
    -- Get directory path to start search from
    local path = vim.api.nvim_buf_get_name(0)
    if path == '' then
      return
    end
    path = vim.fs.dirname(path)

    -- Search upward for root directory
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then
      return
    end
    local root = vim.fs.dirname(root_file)

    -- Set current directory
    vim.fn.chdir(root)
  end,
})
