-- local function my_on_attach(bufnr)
--   -- custom mappings
-- end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  vim.keymap.set("n", "<C-b>", "<cmd>:NvimTreeToggle<cr>", {noremap = true, silent = true})
  ---
}
