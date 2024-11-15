return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require "null-ls"
    local b = null_ls.builtins

    local sources = {
      -- b.formatting.goimports,
      -- b.formatting.gofumpt,
      -- b.diagnostics.golangci_lint,
    }

    null_ls.setup {
      debug = false,
      sources = sources,
    }
  end,
}
