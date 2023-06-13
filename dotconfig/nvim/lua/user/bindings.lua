local options = { noremap = true }
local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

map("i", "jk", "<esc>", options) -- jk to enter normal mode

map("n", "L", ":BufferLineCycleNext<cr>", options) -- next tab
map("n", "H", ":BufferLineCyclePrev<cr>", options) -- prev tab

map("v", "d", '"_d', options) -- delete without yanking
map("v", "p", '"_dP', options) -- paste without yanking
