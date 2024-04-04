return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<Esc>'] = 'close',
          ['<C-j>'] = 'move_selection_next',
          ['<Tab>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<S-Tab>'] = 'move_selection_previous',
        },
      },
      layout_strategy = 'horizontal',
    },
    pickers = {
      buffers = { theme = 'ivy' },
      current_buffer_fuzzy_find = {},
      live_grep = {},
      command_history = {},
      autocommands = {},
      commands = {},
      find_files = { theme = 'ivy' },
      git_files = { theme = 'ivy' },
      help_tags = { theme = 'ivy' },
      oldfiles = { theme = 'ivy' },
    },
  },
}
