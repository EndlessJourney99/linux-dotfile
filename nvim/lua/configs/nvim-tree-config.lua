local function my_on_attach(bufnr)
  -- custom mapping
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-i>", api.node.show_info_popup, opts "show node info popup")
  vim.keymap.set("n", "<C-k>", "5k", opts "move cursor up")
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  vim.keymap.set("n", "<C-b>", "<cmd>:NvimTreeToggle<cr>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<C-x>", "<cmd>:NvimTreeFindFile<cr>", { noremap = true, silent = true }),
  ---
  on_attach = my_on_attach,

  filters = {
    dotfiles = false,
    git_ignored = false,
  },
}
