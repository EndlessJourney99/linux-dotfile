return {
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
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "jq",
        "dockerfile",
        "json",
        "html",
        "terraform",
        "go",
        "tsx",
        "bash",
        "ruby",
        "markdown",
        "c_sharp",
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
}
