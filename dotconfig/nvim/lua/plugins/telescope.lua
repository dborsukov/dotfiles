-- Multi-puprose fuzzy finder
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<Esc>'] = 'close', -- disables normal mode
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
        },
      },
      layout_strategy = 'horizontal',
    },
    pickers = {
      oldfiles = {
        theme = 'dropdown',
      },
      find_files = {
        theme = 'dropdown',
      },
      command_history = {
        theme = 'dropdown',
      },
      help_tags = {
        theme = 'dropdown',
      },
    },
  },
}
