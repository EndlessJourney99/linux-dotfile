return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("spectre").setup()

    vim.keymap.set("n", "<leader>s", '<cmd>lua require("spectre").toggle()<CR>', {
      desc = "Toggle Spectre",
    })
  end,
}
