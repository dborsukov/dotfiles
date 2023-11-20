return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    close_if_last_window = true,
    enable_opened_markers = false,
    enable_modified_markers = false,
    default_component_configs = {
      git_status = {
        symbols = {
          added = '',
          deleted = '',
          modified = '',
          renamed = '',
          untracked = '',
          ignored = '',
          unstaged = '',
          staged = '',
          conflict = '',
        }
      }
    },
    filtered_items = {
      always_show = {
        --'.gitignore',
      },
      never_show = {
        --'.DS_Store',
      },
      never_show_by_pattern = {
        --'.null-ls_',
      },
    },
  },
}
