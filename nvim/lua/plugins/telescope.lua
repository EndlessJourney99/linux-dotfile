return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "joshmedeski/telescope-smart-goto.nvim",
    {
      "isak102/telescope-git-file-history.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "tpope/vim-fugitive",
      },
    },
  },
  config = function()
    local builtin = require "telescope.builtin"
    local git_file_history = require("telescope").extensions.git_file_history
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<C-e>", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set(
      "n",
      "<leader>fg",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Live Grep" }
    )
    vim.keymap.set(
      "n",
      "<leader>fc",
      '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
      { desc = "Live Grep Code" }
    )
    vim.keymap.set("n", "<C-p>", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
    vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
    vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
    vim.keymap.set("n", "<C-f>", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = true,
        layout_config = { width = 0.7 },
      })
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>gh", function()
      git_file_history.git_file_history()
    end, { desc = "Git File History" })
    -- vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })

    local telescope = require "telescope"
    local telescopeConfig = require "telescope.config"
    local gfh_actions = require("telescope").extensions.git_file_history.actions

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    table.insert(vimgrep_arguments, "--ignore-case")
    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    -- table.insert(vimgrep_arguments, "--ignore-case")
    table.insert(vimgrep_arguments, "!**/.git/*")

    local actions = require "telescope.actions"

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end
    telescope.setup {
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<CR>"] = select_one_or_multi,
            ["<C-S-d>"] = actions.delete_buffer,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<C-BS>"] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), "i", false)
            end,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        undo = {
          use_delta = true,
          use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }

          side_by_side = false,
          vim_diff_opts = { ctxlen = vim.o.scrolloff },
          entry_format = "state #$ID, $STAT, $TIME",
          mappings = {
            i = {
              ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<cr>"] = require("telescope-undo.actions").restore,
            },
          },
        },
        git_file_history = {
          -- Keymaps inside the picker
          mappings = {
            i = {
              ["<C-g>"] = gfh_actions.open_in_browser,
            },
            n = {
              ["<C-g>"] = gfh_actions.open_in_browser,
            },
          },

          -- The command to use for opening the browser (nil or string)
          -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
          browser_command = nil,
        },
      },
    }

    require("telescope").load_extension "neoclip"

    require("telescope").load_extension "fzf"

    require("telescope").load_extension "ui-select"

    require("telescope").load_extension "undo"

    require("telescope").load_extension "advanced_git_search"

    require("telescope").load_extension "live_grep_args"

    require("telescope").load_extension "colors"

    require("telescope").load_extension "noice"

    require("telescope").load_extension "git_file_history"

    vim.g.zoxide_use_select = true
  end,
}
