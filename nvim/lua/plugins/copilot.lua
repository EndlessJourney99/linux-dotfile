return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set("i", "<C-Tab>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.keymap.set("i", "<C-S-Tab>", "<Plug>(copilot-accept-word)", { noremap = true, silent = true })
    vim.g.copilot_no_tab_map = false
  end,
}
