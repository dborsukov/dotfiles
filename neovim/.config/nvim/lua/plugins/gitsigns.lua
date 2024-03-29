return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set({ 'n', 'v' }, ']c', function()
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Git: Next hunk' })
      vim.keymap.set({ 'n', 'v' }, '[c', function()
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Git: Prev hunk' })
    end,
  },
}
