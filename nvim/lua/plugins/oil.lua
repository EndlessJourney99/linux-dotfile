return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup {
      -- your configuration comes here
      float = {
        padding = 4,
        max_width = 80,
        max_height = 400,
      },
      keymaps = {
        ["<ESC>"] = "<cmd>lua require('oil').close()<cr>",
        ["<Tab>"] = ""
      },
    }

    vim.keymap.set("n", "-", "<cmd>:Oil --float <cr>", { noremap = true, silent = true })
  end,
}
