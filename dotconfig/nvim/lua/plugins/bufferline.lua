---@diagnostic disable: missing-fields
-- Shows opened buffers as tabs
return {
  'akinsho/bufferline.nvim',
  version = '*',
  config = function()
    require('bufferline').setup({
      options = {
        sort_by = 'directory',
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'center',
            separator = false,
          }
        },
      },
    })
  end,
}
