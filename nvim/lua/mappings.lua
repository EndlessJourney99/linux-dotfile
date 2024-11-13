require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del
-- remove unwanted map first
nomap("n", "<leader>v")
nomap("n", "<C-c>")
nomap("n", "<C-n>")
nomap("n", "<leader>b")

-- add new map
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kk", "<ESC>")
map({ "n" }, "<C-CR>", "o<ESC>", { noremap = true, silent = true })
map({ "i" }, "<C-CR>", "<ESC>o", { noremap = true, silent = true })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = false })
map("v", "/r", '"hy:%s@<C-r>h@@g<left><left>', { noremap = true, silent = false })
map({"n", "v"}, "<C-j>", "5j", { noremap = true, silent = true })
map({"n", "v"}, "<C-k>", "5k", { noremap = true, silent = true })
map({ "v", "n" }, "<M-k>", "ddkkp", { noremap = true, silent = true })
map({ "v", "n" }, "<M-j>", "ddp", { noremap = true, silent = true })
map("n", "<leader>Q", "<cmd>q!<cr>", { noremap = true, silent = true })
map("n", "<leader>wq", "<cmd>wq<cr>", { noremap = true, silent = true })
map("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })


require "custom-func.quote-selector"
