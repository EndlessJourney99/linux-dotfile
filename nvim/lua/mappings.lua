require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del
-- remove unwanted map first
nomap("n", "<leader>v")
nomap("n", "<C-c>")
nomap("n", "<C-n>")
nomap("n", "<leader>b")
nomap("n", "<leader>wk")
nomap("n", "<leader>wK")
nomap("n", "<M-h>")

-- tmux
map("n", "<M-h>", [[<cmd>lua require('tmux').move_left()<cr>]], { desc = "Go left tmux window" })
map("n", "<M-S-j>", [[<cmd>lua require('tmux').move_down()<cr>]], { desc = "Go top tmux window" })
map("n", "<M-S-k>", [[<cmd>lua require('tmux').move_up()<cr>]], { desc = "Go bottom tmux window" })
map("n", "<M-l>", [[<cmd>lua require('tmux').move_right()<cr>]], { desc = "Go right tmux window" })

-- add new map
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kk", "<ESC>")
map({ "n" }, "<C-CR>", "o<ESC>", { noremap = true, silent = true })
map({ "i" }, "<C-CR>", "<ESC>o", { noremap = true, silent = true })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = false })
map("n", "<C-/>", "*", { noremap = true, silent = true })
map("n", "<C-S-/>", function()
  vim.cmd "let @/ = ''"
end, { noremap = true, silent = true })
map("v", "/r", '"hy:%s@<C-r>h@@g<left><left>', { noremap = true, silent = false })
map({ "n", "v" }, "<C-j>", "5j", { noremap = true, silent = true })
map({ "n", "v" }, "<C-k>", "5k", { noremap = true, silent = true })

-- Move code
map({ "n" }, "<M-k>", "ddkkp", { noremap = true, silent = true })
map({ "n" }, "<M-j>", "ddp", { noremap = true, silent = true })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })

map("n", "<leader>Q", "<cmd>q!<cr>", { noremap = true, silent = true })
map("n", "<C-w-q>", "<cmd>wq<cr>", { noremap = true, silent = true })
map("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
map("i", "<C-DEL>", "<ESC><right>cw", { noremap = true, silent = true })
map({ "n", "v", "o" }, "<C-m>", "%", { noremap = true, silent = true })
map("n", "<C-h>", function()
  require("nvchad.tabufline").prev()
end, { noremap = true, silent = true, desc = "Move to previous tab" })
map("n", "<C-l>", function()
  require("nvchad.tabufline").next()
end, { noremap = true, silent = true, desc = "Move to previous tab" })
map({ "n", "t" }, "<M-`>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })
map({ "n", "v", "o" }, "x", "d", { noremap = true, silent = true })
map({ "n", "v", "o" }, "X", "D", { noremap = true, silent = true })
map({ "n", "v", "o" }, "xx", "dd", { noremap = true, silent = true })

map("v", "=", function()
  require("conform").format({ async = true, lsp_fallback = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    else
      print("Error formatting: " .. err)
    end
  end)
end, { desc = "Format selection code" })

require "custom-func.quote-selector"
require "custom-func.buffer-handler"
