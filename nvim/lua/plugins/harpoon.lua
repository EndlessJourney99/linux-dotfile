return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("harpoon").setup {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 50,
        height = vim.api.nvim_win_get_height(0) - 10,
      }
    }

    vim.keymap.set("n", "<C-->", function()
      require("harpoon.ui").toggle_quick_menu()
    end, { noremap = true, silent = true, desc = "Toggle Harpoon" })
    vim.keymap.set("n", "<C-=>", function()
      require("harpoon.mark").add_file()
    end, { noremap = true, silent = true, desc = "Add file to harpoon" })
  end,
}
