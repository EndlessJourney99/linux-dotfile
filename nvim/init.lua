vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- custom configuration
require "options"
require "autocmds"
require "configs.nvim-tree-config"

vim.schedule(function()
  require "mappings"

  vim.cmd "hi IlluminatedWordText guibg=none gui=underline"
  vim.cmd "hi IlluminatedWordRead guibg=none gui=underline"
  vim.cmd "hi IlluminatedWordWrite guibg=none gui=underline"
  vim.cmd "set linebreak"
  vim.lsp.set_log_level "off"

  require("nvim-highlight-colors").setup {
    enable_named_colors = false,
  }
  require "exosyphon.globals"
  require "exosyphon.remaps"
  require "exosyphon.options"
  require("dapui").setup()
end)

vim.filetype.add {
  extension = {
    json = "jsonc",
  },
}
