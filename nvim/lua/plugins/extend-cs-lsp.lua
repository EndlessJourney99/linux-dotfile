return {
  "Decodetalkers/csharpls-extended-lsp.nvim",
  dependencies = {
    "VonHeikemen/lsp-zero.nvim",
    opts = {
      config = {
        csharp_ls = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
          end,
        },
      },
    },
  },
  config = function()
  end,
}
