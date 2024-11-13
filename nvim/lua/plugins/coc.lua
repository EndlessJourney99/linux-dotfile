return {
  'neoclide/coc.nvim',
  branch = 'release',
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<C-M-.>", "<Plug>(coc-codeaction-selected)j")
  end,
}
