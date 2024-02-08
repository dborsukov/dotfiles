-- Git integration
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
      vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
      vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
      vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
      vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
      vim.keymap.set('n', '<leader>gS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
      vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
      vim.keymap.set('n', '<leader>gb', function()
        gs.blame_line({ full = true })
      end, { buffer = bufnr, desc = 'Line blame' })
    end,
  },
}
