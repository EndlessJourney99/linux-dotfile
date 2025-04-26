return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        max_lines = 5,
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        autojump = false,
      },
      search = {
        mode = "search",
      },
      modes = {
        char = {
          jump_labels = true,
          multi_line = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n" },           function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  "mg979/vim-visual-multi",
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)

      return {
        ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },

        highlight = {
          enable = true,
          use_languagetree = true,
        },

        indent = { enable = true },
      }
    end,
    config = function()
      local configs = require "nvim-treesitter.configs"

      configs.setup {
        ensure_installed = {
          "html",
          "javascript",
          "typescript",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "jq",
          "dockerfile",
          "json",
          "html",
          "go",
          "tsx",
          "bash",
          "ruby",
          "markdown",
          "c_sharp",
          "python",
        },
        sync_install = false,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-CR>",
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>p"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>ps"] = "@parameter.inner",
            },
          },
        },
      }
    end,
  },
  {
    "EndlessJourney99/treesj",
    branch = "support-for-csharp",
    requires = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesj").setup { --[[ your config ]]
        use_default_keymaps = false,
        max_join_length = 500,
        vim.keymap.set("n", "<C-S-t>", "<cmd>TSJToggle<CR>", { noremap = true, silent = true }),
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        surrounds = {
          ["("] = {
            add = function()
              return { { "(" }, { ")" } }
            end,
          },
          ["{"] = {
            add = function()
              return { { "{" }, { "}" } }
            end,
          },
          ["["] = {
            add = function()
              return { { "[" }, { "]" } }
            end,
          },
          ["<"] = {
            add = function()
              return { { "<" }, { ">" } }
            end,
          },
        },
      }
    end,
  },
}
