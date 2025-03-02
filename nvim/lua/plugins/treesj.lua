return {
  "EndlessJourney99/treesj",
  branch = "support-for-csharp",
  requires = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("treesj").setup {--[[ your config ]]
      use_default_keymaps = false,
      max_join_length = 500,
      vim.keymap.set("n", "<C-S-t>", "<cmd>TSJToggle<CR>", { noremap = true, silent = true }),
    }
  end,
}
