vim.cmd [[
try
  colorscheme base16-gruvbox-dark-hard
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry
]]
