local function is_split()
  -- Get the number of windows
  local num_windows = vim.fn.winnr "$"

  -- -- Get the number of listed buffers
  -- local buffers = vim.fn.getbufinfo { buflisted = 0 }

  -- Conditions:
  -- 1. More than one window implies a split.
  -- 2. No next buffer means only one listed buffer exists.
  -- local no_next_buffer = #buffers <= 1

  return num_windows > 1
end

local function have_next_buffer()
  -- Get the number of listed buffers
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  -- Conditions:
  -- 1. More than one window implies a split.
  -- 2. No next buffer means only one listed buffer exists.
  return #buffers > 1
end

local function jump_back_old_buffer_from_cursor()
  local last_buffer = vim.fn.bufnr "#"
  local current_buffer = vim.fn.bufnr "%"
  local last_window = vim.fn.bufwinid(last_buffer)

  -- local current_window = vim.fn.bufwinid(current_buffer)
  -- print("is current window valid: ", vim.api.nvim_buf_is_loaded(current_buffer))
  -- print("is last window valid: ", vim.api.nvim_buf_is_loaded(last_buffer))
  if vim.api.nvim_buf_is_loaded(last_buffer) == false then
    vim.cmd "bp"
    return
  end
  if last_buffer ~= current_buffer then
    vim.cmd(last_window .. "wincmd w")
  end

  vim.cmd "buffer #"
end

local function is_nvim_tree_open()
  local view = require "nvim-tree.view"
  return view.is_visible()
end

local function smart_delete_buffer()
  -- Get the current window ID
  local win_id = vim.api.nvim_get_current_win()
  -- Get the position of the window: {row, col}
  local pos = vim.api.nvim_win_get_position(win_id)

  -- Screen dimensions
  local total_width = vim.o.columns
  -- local total_height = vim.o.lines

  local is_top = pos[1] == 1
  local is_left = pos[2] == 0
  -- local is_bottom = pos[1] + 1 >= total_height - vim.api.nvim_win_get_height(win_id)
  local is_right = pos[2] >= total_width - vim.api.nvim_win_get_width(win_id)
  local is_not_vertical_split = (is_left or is_nvim_tree_open()) and is_right

  if is_top and have_next_buffer() and is_not_vertical_split then
    jump_back_old_buffer_from_cursor()
    vim.cmd "bd #"
  else
    vim.cmd "bd"
  end
end

vim.keymap.set("n", "<leader>w", smart_delete_buffer, { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>", smart_delete_buffer, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", smart_delete_buffer, { noremap = true, silent = true })
