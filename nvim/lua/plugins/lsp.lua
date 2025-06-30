return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    { -- Optional
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd, "MasonUpdate")
      end,
    },
    { "williamboman/mason-lspconfig.nvim" }, -- Optional
    -- Autocompletion
    { "hrsh7th/nvim-cmp" }, -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" }, -- Required
    { "rafamadriz/friendly-snippets" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
  },
  config = function(config)
    local lsp = require "lsp-zero"

    require("mason").setup {}
    require("mason-lspconfig").setup {
      ensure_installed = {
        "rust_analyzer",
        "jdtls",
        "lua_ls",
        "html",
        "tflint",
        "dockerls",
        "bashls",
        "marksman",
        "gopls",
        "astro",
      },
      handlers = {
        lsp.default_setup,
        lua_ls = function()
          local lua_opts = lsp.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
      },
    }

    local cmp_action = require("lsp-zero").cmp_action()
    local cmp = require "cmp"
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    require("luasnip.loaders.from_vscode").lazy_load()
    -- require("lspconfig").csharp_ls.setup(config)
    -- require("csharpls_extended").buf_read_cmd_bind()
    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline {
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-CR>"] = {
          c = cmp.mapping.confirm { select = false },
        },
      },
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline {
        ["<C-CR>"] = {
          c = cmp.mapping.confirm { select = false },
        },
      },
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    cmp.setup {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-\\>"] = cmp.mapping.complete(),
        ["<ESC>"] = cmp.mapping.close(),
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
      },
    }
  end,
}
