local map = vim.keymap.set
local nomap = vim.keymap.del
-- nvchad
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)


-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- remove unwanted map
nomap("n", "<leader>v")
nomap("n", "<C-c>")
nomap("n", "<C-n>")
nomap("n", "<leader>wk")
nomap("n", "<leader>wK")
nomap("n", "<M-h>")
nomap("n", "<C-w>")

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
