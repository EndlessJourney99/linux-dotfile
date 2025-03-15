return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = function()
    dofile(vim.g.base46_cache .. "mason")

    return {
      PATH = "skip",

      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },

      max_concurrent_installers = 10,
    }
  end,

  config = function()
    local mason = require "mason"
    local mason_tool_installer = require "mason-tool-installer"

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      registries = {
        "github:mason-org/mason-registry",
        "github:syndim/mason-registry",
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "prettier",
        "prettierd",
        "beautysh",
        "buf",
        "rustfmt",
        "taplo",
        "shellcheck",
        "gopls",
        "delve",
        "astro-language-server",
      },
    }
  end,
}
