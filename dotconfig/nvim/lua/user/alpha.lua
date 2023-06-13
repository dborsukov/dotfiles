local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

dashboard.section.buttons.val = {
    dashboard.button("n", "New file", ":ene <BAR> startinsert <CR>", {}),
    dashboard.button("f", "Find files", ":cd $HOME | Telescope find_files theme=dropdown previewer=false<CR>", {}),
    dashboard.button("r", "Recent", ":Telescope oldfiles theme=dropdown previewer=false<CR>", {}),
    dashboard.button("p", "Projects", ":Telescope projects theme=dropdown previewer=false<CR>", {}),
    dashboard.button("c", "Config", ":e ~/.config/nvim/lua/user/<CR>", {}),
    dashboard.button("q", "Quit", ":qa<CR>", {}),
}

require("alpha").setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
