---@diagnostic disable: missing-fields, empty-block

-- This should always be done before Lazy
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

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
        'matchit',
        'rplugin',
        'tarPlugin',
        'zipPlugin',
        'matchparen',
        'netrwPlugin',
      },
    },
  },
})

vim.o.scrolloff = 7
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.timeoutlen = 200
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.termguicolors = true

vim.bo.undofile = true
vim.bo.expandtab = true

vim.wo.wrap = false
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.colorcolumn = '100'
vim.wo.relativenumber = true

require('telescope').load_extension('fzf')

vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'File manager' })
vim.keymap.set('n', '<leader>.', require('telescope.builtin').buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'Fuzzy find' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').live_grep, { desc = 'Grep workdir' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sa', require('telescope.builtin').autocommands, { desc = 'Autocommands' })
vim.keymap.set('n', '<leader>sC', require('telescope.builtin').command_history, { desc = 'Recent commands' })

require('which-key').register({
  ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
})

vim.diagnostic.config({
  signs = false,
  underline = true,
  virtual_text = false,
})

local function enhanced_float_handler(handler)
  return function(err, result, ctx, config)
    handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend('force', config or {}, {
        border = vim.g.floating_window_border,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
      })
    )
  end
end

vim.lsp.handlers['textDocument/hover'] = enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers['textDocument/signatureHelp'] = enhanced_float_handler(vim.lsp.handlers.signature_help)

local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    -- handled by conform.nvim
  end

  if client.supports_method('textDocument/hover') then
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })
  end

  if client.supports_method('textDocument/signatureHelp') then
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })
  end

  if client.supports_method('textDocument/publishDiagnostics') then
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'LSP: Next diagnostic' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'LSP: Prev diagnostic' })
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { buffer = bufnr, desc = 'Line diagnostics' })
    vim.keymap.set('n', '<leader>ld', require('telescope.builtin').diagnostics, { buffer = bufnr, desc = 'Open diagnostics' })
  end

  if client.supports_method('textDocument/rename') then
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
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

-- Available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
-- Configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- These configs are also accessible with ':help lspconfig-all'
local servers = {
  bashls = {},
  clangd = {},
  gopls = {},
  lua_ls = {
    settings = {
      Lua = {
        format = { enable = false },
        telemetry = { enable = false },
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          enable = true,
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        },
      },
    },
  },
  pyright = {},
  rust_analyzer = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'black',
  'isort',
  'stylua',
})

require('mason').setup()
require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.on_attach = on_attach
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
})
