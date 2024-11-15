return {
  'moll/vim-bbye',
  lazy = true,
  event = 'BufRead',
  config = function()
    vim.keymap.set("n", '<leader>q', '<cmd>Bdelete<CR>', { silent = true, desc = 'Close buffer' })
  end,
}
