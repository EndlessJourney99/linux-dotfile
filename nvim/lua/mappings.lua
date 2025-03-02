local map = vim.keymap.set
local nomap = vim.keymap.del
-- nvchad
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

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

-- -- whichkey
-- map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
--
-- map("n", "<leader>wk", function()
--   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
-- end, { desc = "whichkey query lookup" })

-- remove unwanted map
nomap("n", "<leader>v")
nomap("n", "<C-c>")
nomap("n", "<C-n>")
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
map("v", "/f", ":s/\\(.*\\)/", { noremap = true, silent = false })
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

-- Jump between markdown headers
vim.keymap.set("n", "gj", [[/^##\+ .*<CR>]], { buffer = true, silent = true })
vim.keymap.set("n", "gk", [[?^##\+ .*<CR>]], { buffer = true, silent = true })

-- Exit insert mode without hitting Esc
vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })

-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$")

-- Select all
vim.keymap.set("n", "==", "gg<S-v>G")

-- Keep window centered when going up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste without overwriting register
vim.keymap.set("v", "p", '"_dP')

-- Copy text to " register
vim.keymap.set("n", "<leader>y", '"+y', { desc = 'Yank into " register' })
vim.keymap.set("v", "<leader>y", '"+y', { desc = 'Yank into " register' })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = 'Yank into " register' })

-- Delete text to " register
vim.keymap.set("n", "<leader>d", '"_d', { desc = 'Delete into " register' })
vim.keymap.set("v", "<leader>d", '"_d', { desc = 'Delete into " register' })

-- Get out Q
vim.keymap.set("n", "Q", "<nop>")

-- Navigate between quickfix items
vim.keymap.set("n", "<leader>h", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
vim.keymap.set("n", "<leader>;", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- Navigate between location list items
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list" })

-- -- Replace word under cursor across entire buffer
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],rema
--   { desc = "Replace word under cursor" })

-- Run Tests
vim.keymap.set("n", "<leader>tc", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run Current Nearest Test" })
vim.keymap.set(
  "n",
  "<leader>tf",
  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { desc = "Run Test File" }
)
vim.keymap.set(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<CR>",
  { desc = "Run Current Test Directory" }
)
vim.keymap.set(
  "n",
  "<leader>tp",
  "<cmd>lua require('neotest').output_panel.toggle()<CR>",
  { desc = "Toggle Test Output Panel" }
)
vim.keymap.set("n", "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", { desc = "Run Last Test" })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle Test Summary" })

-- Debug Tests
vim.keymap.set("n", "<F4>", "<cmd>lua require('dap-go').debug_test()<CR>", { desc = "Start Debugging Current Test" })
vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Start Debugging" })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Start Debugging" })
vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>dsu", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
vim.keymap.set("n", "<leader>dst", "<cmd>DapStepTerminate<CR>", { desc = "Stop Debugger" })
vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set(
  "n",
  "<leader>B",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Toggle Breakpoint Condition" }
)
vim.keymap.set(
  "n",
  "<leader>E",
  "<cmd>lua require'dap'.set_exception_breakpoints()<CR>",
  { desc = "Toggle Exception Breakpoint" }
)
vim.keymap.set(
  "n",
  "<leader>dr",
  "<cmd>lua require'dapui'.float_element('repl', { width = 100, height = 40, enter = true })<CR>",
  { desc = "Show DAP REPL" }
)
vim.keymap.set(
  "n",
  "<leader>ds",
  "<cmd>lua require'dapui'.float_element('scopes', { width = 150, height = 50, enter = true })<CR>",
  { desc = "Show DAP Scopes" }
)
vim.keymap.set(
  "n",
  "<leader>df",
  "<cmd>lua require'dapui'.float_element('stacks', { width = 150, height = 50, enter = true })<CR>",
  { desc = "Show DAP Stacks" }
)
vim.keymap.set(
  "n",
  "<leader>db",
  "<cmd>lua require'dapui'.float_element('breakpoints', { enter = true })<CR>",
  { desc = "Show DAP breakpoints" }
)
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debug Last Test" })
vim.keymap.set("n", "<leader>s", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
-- Copy file paths
vim.keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
end, { desc = "Source current file" })

-- Dismiss Noice Message
vim.keymap.set("n", "<S-Esc>", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- Open Zoxide telescope extension
vim.keymap.set("n", "<leader>Z", "<cmd>Zi<CR>", { desc = "Open Zoxide" })

-- Resize with arrows
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", { desc = "Resize Horizontal Split Down" })
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", { desc = "Resize Horizontal Split Up" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Down" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Up" })

-- -- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "<", "v<gv<Esc>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", ">", "v>gv<Esc>")

vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Jump to beginning of line" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Jump to end of line" })

-- Exit terminal mode shortcut
vim.keymap.set("t", "<C-t>", "<C-\\><C-n>")

-- Autocommands
vim.api.nvim_create_augroup("custom_buffer", { clear = true })

-- start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Auto enter insert mode when opening a terminal",
  group = "custom_buffer",
  pattern = "*",
  callback = function()
    -- Wait briefly just in case we immediately switch out of the buffer (e.g. Neotest)
    vim.defer_fn(function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "terminal" then
        vim.cmd [[startinsert]]
      end
    end, 100)
  end,
})

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "custom_buffer",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
  end,
})

-- save sudo
vim.keymap.set("n", "<C-M-s>", "<cmd>SudaWrite<CR>", { desc = "Save file as sudo" })
require "custom-func.quote-selector"
require "custom-func.buffer-handler"
