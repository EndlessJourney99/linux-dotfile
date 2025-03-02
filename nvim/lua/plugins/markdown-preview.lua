return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  event = "BufRead",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install && git restore .",
  init = function()
    vim.g.mkdp_filetypes = { "markdown", "mermaid" }
  end,
  ft = { "markdown", "mermaid" },
}
