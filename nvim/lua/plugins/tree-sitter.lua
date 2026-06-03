return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)
    end,
    config = function()
      local ts = require "nvim-treesitter"

      -- Set the priority runtime directory path
      ts.setup {
        install_dir = vim.fn.stdpath "data" .. "/site",
      }

      -- Asynchronously bootstrap your explicit list of languages
      ts.install {
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
        "go",
        "tsx",
        "bash",
        "ruby",
        "markdown",
        "c_sharp",
        "python",
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          -- This natively triggers the 0.12 syntax engine for Golang
          -- vim.treesitter.start(args.buf)
          pcall(vim.treesitter.start)
        end,
      })

    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main", -- Ensure 0.12 compatibility
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      }
      -- 1. Direct Selection Mappings (Operator-pending and Visual modes)
      local textobjects = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }

      for key, query in pairs(textobjects) do
        vim.keymap.set({ "x", "o" }, key, function()
          -- Updated to use the 0.12 flat module method layout
          require "nvim-treesitter-textobjects.select".select_textobject(query, "textobjects")
        end, { desc = "Select textobject " .. query })
      end

      -- 2. Direct Jump Movements (Normal, Visual, and Operator modes)
      local movements = {
        ["]f"] = { query = "function.outer", method = "goto_next_start" },
        ["]]"] = { query = "class.outer", method = "goto_next_start" },
        ["]F"] = { query = "function.outer", method = "goto_next_end" },
        ["]["] = { query = "class.outer", method = "goto_next_end" },
        ["[f"] = { query = "function.outer", method = "goto_previous_start" },
        ["[["] = { query = "class.outer", method = "goto_previous_start" },
        ["[F"] = { query = "function.outer", method = "goto_previous_end" },
        ["[]"] = { query = "class.outer", method = "goto_previous_end" },
      }

      for key, config in pairs(movements) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          local command = string.format(
            "lua require('nvim-treesitter-textobjects.move').%s('@%s', 'textobjects')",
            config.method,
            config.query
          )
          pcall(vim.api.nvim_exec2, command, {})
        end, { desc = "Jump " .. config.query })
      end

      -- 3. Direct Swapping Mappings (Normal mode targets)
      vim.keymap.set("n", "<leader>p", function()
        pcall(function()
          require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
        end)
      end, { desc = "Swap parameter with next" })

      vim.keymap.set("n", "<leader>ps", function()
        pcall(function()
          require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
        end)
      end, { desc = "Swap parameter with previous" })
    end,
  },
}
