local g = vim.o
local v = vim.g
local w = vim.wo
local b = vim.bo

--global options
g.hidden = true
g.laststatus = 3
g.mouse = "a"
g.scrolloff = 7
g.sdf = "/tmp/.viminfo"
g.showmode = false
g.swapfile = false
g.termguicolors = true
g.timeoutlen = 500

--window local options
w.colorcolumn = "100"
w.number = true
w.relativenumber = true
w.wrap = false

--buffer local options
b.autoindent = true
b.copyindent = true
b.expandtab = true
b.fileformat = "unix"
b.filetype = "plugin"
b.shiftwidth = 4
b.softtabstop = -1
b.undofile = true

--global vim opts
v.floaterm_height = 0.6
v.floaterm_width = 0.8
v.vimtex_compiler_method = "latexmk"
v.vimtex_view_method = "zathura"
