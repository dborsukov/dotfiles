local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- since space is a <leader> ensure no additional bindings are set
map("n", "<space>", "<nop>")

-- 'jk' to exit insert mode
map("i", "jk", "<esc>")

-- bufferline helpers
map("n", "L", ":BufferLineCycleNext<cr>")
map("n", "H", ":BufferLineCyclePrev<cr>")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "n", "v", "s" }, "<C-s>", "<cmd>w<cr><esc>")
