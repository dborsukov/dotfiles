-- Fast and easy movement
return {
  'ggandor/leap.nvim',
  config = function()
    require('leap').set_default_keymaps(true)
  end,
}
