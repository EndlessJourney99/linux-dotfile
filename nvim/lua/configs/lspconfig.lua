local map = vim.keymap.set

-- export on_attach & capabilities
local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
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

  require("lspconfig").lua_ls.setup {
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
  }
end

-- load defaults i.e lua_lsp
defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "gopls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   root_dir = lspconfig.util.root_pattern "package.json",
--   single_file_support = false,
-- }
--
-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
