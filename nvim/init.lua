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
-- dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- custom configuration
require "options"
require "autocmds"
require "configs.nvim-tree-config"

vim.schedule(function()
  require "mappings"

  vim.cmd("colorscheme catppuccin")
  vim.cmd "hi IlluminatedWordText guibg=none gui=underline"
  vim.cmd "hi IlluminatedWordRead guibg=none gui=underline"
  vim.cmd "hi IlluminatedWordWrite guibg=none gui=underline"
  vim.cmd "set linebreak"
  vim.cmd "set noswapfile"
  vim.lsp.set_log_level "off"

  require("nvim-highlight-colors").setup {
    enable_named_colors = false,
  }

  require("dapui").setup {
    render = {
      max_type_length = nil, -- don't truncate type names
    },
  }

  require("configs.dotnet-dap").register_net_dap()

  vim.o.ttyfast = true
  vim.o.lazyredraw = false
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "redraw!",
  })
end)

vim.filetype.add {
  extension = {
    json = "jsonc",
  },
}
