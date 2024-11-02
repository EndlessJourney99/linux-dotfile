return {
  "folke/trouble.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("trouble").setup {
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.4, height = 0.4 },
        zindex = 200,
        scratch = true,
      },
    }

    vim.keymap.del("n", "<leader>x")
    vim.keymap.set("n", "<leader>x", "<cmd>Trouble diagnostics toggle focus=true<CR>", { desc = "Trouble" })
  end,
}
