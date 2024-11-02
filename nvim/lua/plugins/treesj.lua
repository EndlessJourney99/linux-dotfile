return {
  "Wansmer/treesj",
  requires = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup {--[[ your config ]]
      vim.keymap.set("n", "<C-S-t>", "<cmd>TSJToggle<CR>", { noremap = true, silent = true }),
    }
  end,
}
