-- Session manager built on top of ':mksession'
return {
  'Shatur/neovim-session-manager',
  config = function()
    local sm = require('session_manager')
    local sm_config = require('session_manager.config')
    sm.setup({
      autosave_only_in_session = true,
      autoload_mode = sm_config.AutoloadMode.Disabled,
    })
  end,
}
