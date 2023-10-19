return {
  -- Base16 colorschemes
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
    end,
  },
  { "nyoom-engineering/oxocarbon.nvim" },
}
