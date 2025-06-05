vim.g.mapleader = " "
local map = vim.keymap.set
local vscode = require "vscode"

local function mapMove(mode, key, direction, lines)
  vim.keymap.set(mode, key, function()
    if lines == nil or lines == 0 then
      lines = 1
    end
    local v = lines
    local style = "wrappedLine"
    -- if v > 0 then
    --   style = 'line'
    -- end
    vscode.action("cursorMove", {
      args = {
        to = direction,
        by = style,
        value = v,
      },
    })
    return "<esc>"
  end, options)
end

mapMove("n", "j", "down")
mapMove("n", "k", "up")
mapMove("n", "h", "left")
mapMove("n", "l", "right")
mapMove("n", "<C-j>", "down", 5)
mapMove("n", "<C-k>", "up", 5)

map("v", "<C-k>", "5k", { noremap = true, silent = true })
map("v", "<C-j>", "5j", { noremap = true, silent = true })

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })

-- add new map
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "CMD enter command mode" })
map({ "n" }, "<C-CR>", "o<ESC>", { noremap = true, silent = true })
map({ "i" }, "<C-CR>", "<ESC>o", { noremap = true, silent = true })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { noremap = true, silent = false })
map("v", "/f", ":s/\\(.*\\)/", { noremap = true, silent = false })
-- map("n", "<C-/>", "*", { noremap = true, silent = true })
map("n", "<C-S-/>", function()
  vim.cmd "silent noh"
end, { noremap = true, silent = true })
map("v", "/r", '"hy:%s@<C-r>h@@g<left><left>', { noremap = true, silent = false })
map("n", "<C-A-n>", "<cmd>enew<CR>", { noremap = true, silent = true })

-- Move code
map("n", "<leader>Q", "<cmd>q!<cr>", { noremap = true, silent = true })

map("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
map("i", "<C-DEL>", "<ESC><right>cw", { noremap = true, silent = true })
map({ "n", "v", "o" }, "<C-m>", "%", { noremap = true, silent = true })
map({ "n", "v", "o" }, "x", "d", { noremap = true, silent = true })
map({ "n", "v", "o" }, "X", "D", { noremap = true, silent = true })
map({ "n", "v", "o" }, "xx", "dd", { noremap = true, silent = true })

map("v", "=", function()
  vscode.action "editor.action.formatSelection"
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

-- Copy file paths
vim.keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
end, { desc = "Source current file" })

-- Dismiss Noice Message
vim.keymap.set("n", "<S-Esc>", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

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

require "custom-func.quote-selector"

-- vscode
map({ "n", "v" }, "<C-b>", function()
  vscode.action "workbench.files.action.showActiveFileInExplorer"
end, { noremap = true, silent = true })

-- map({ "n", "v" }, "y", function()
--   vscode.action "editor.action.clipboardCopyAction"
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "v", true)
-- end, { noremap = true, silent = true })

map("n", "<C-,>", function()
  vscode.action "editor.action.showHover"
end, { noremap = true, silent = true })

map("n", "gr", function()
  vscode.action "editor.action.referenceSearch.trigger"
end, { noremap = true, silent = true })

map("n", "gi", function()
  vscode.action "editor.action.goToImplementation"
end, { noremap = true, silent = true })

map("n", "<leader>fm", function()
  vscode.action "editor.action.formatDocument"
end, { noremap = true, silent = true })

map("n", "za", function()
  vscode.action "editor.toggleFold"
end, { noremap = true, silent = true })

map("n", "<C-e>", function()
  vscode.action "workbench.action.quickOpen"
end, { noremap = true, silent = true })

map({ "n", "v" }, "<C-l>", function()
  vscode.action "workbench.action.nextEditor"
end, { noremap = true, silent = true })

map({ "n", "v" }, "<C-h>", function()
  vscode.action "workbench.action.previousEditor"
end, { noremap = true, silent = true })

map("n", "<leader>b", function()
  vscode.action "editor.debug.action.toggleBreakpoint"
end, { noremap = true, silent = true })

map("n", "]d", function()
  vscode.action "editor.action.marker.nextInFiles"
end, { noremap = true, silent = true })

map("n", "[d", function()
  vscode.action "editor.action.marker.prevInFiles"
end, { noremap = true, silent = true })

map({ "n", "v" }, "<M-j>", function()
  vscode.action "editor.action.moveLinesDownAction"
end, { noremap = true, silent = true })

map({ "n", "v" }, "<M-k>", function()
  vscode.action "editor.action.moveLinesUpAction"
end, { noremap = true, silent = true })

map({ "n", "v" }, "<leader>e", function()
  vscode.action "settings.cycle.activityBar"
end, { noremap = true, silent = true })

-- map("n", "<leader>do", function()
--   vscode.action "workbench.view.debug"
--   vscode.action "workbench.debug.action.toggleRepl"
-- end, { noremap = true, silent = true })

-- map("n", "<M-k>", function()
--   vscode.action "quickInput.next"
-- end, { noremap = true, silent = true })
--
-- map("n", "<M-j>", function()
--   vscode.action "quickInput.previous"
-- end, { noremap = true, silent = true })
-- Plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  { import = "vscode_plugins" },
}, lazy_config)



-- options
local opt = vim.opt
local o = vim.o

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.splitright = true
o.timeoutlen = 200
o.undofile = true
o.updatetime = 250
opt.whichwrap:append "<>[]hl"

o.numberwidth = 1
o.number = false
o.ruler = false

vim.cmd "set linebreak"
