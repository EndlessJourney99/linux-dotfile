-- export on_attach & capabilities
local on_attach = function(client, bufnr)
  -- if client.name ~= "csharp_ls" then return end
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
  vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.setloclist()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
  vim.keymap.set("n", "<C-,>", function()
    vim.diagnostic.open_float()
  end, vim.tbl_deep_extend("force", opts, { desc = "Show full diagnostic" }))
  vim.keymap.set("n", "<C-.>", function()
    vim.lsp.buf.code_action()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
  vim.keymap.set("n", "<F2>", function()
    vim.lsp.buf.rename()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
  vim.keymap.set("n", "<C-[>", function()
    vim.lsp.buf.hover()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))

  -- map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  -- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  -- map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  --
  -- map("n", "<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts "List workspace folders")
  --
  -- map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  --
  -- -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  -- map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end

-- load defaults i.e lua_lsp
defaults()

-- local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "ts_ls", "cssls", "gopls" }

-- Define shared config items
local common = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    onIgnoredFiles = "off",
  },
}

-- Register each server’s config
for _, srv in ipairs(servers) do
  vim.lsp.config(srv, common)
end

-- Now enable them
vim.lsp.enable(servers)

-- For servers needing custom config
local custom = {
  cmd = { "csharp-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
  -- add more server-specific fields: filetypes, root_dir, settings, etc.
}
vim.lsp.config("csharp_ls", custom)
vim.lsp.enable "csharp_ls"

require("csharpls_extended").buf_read_cmd_bind()
