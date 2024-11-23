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

local function smart_delete_buffer()
  -- Get the current window ID
  local win_id = vim.api.nvim_get_current_win()
  -- Get the position of the window: {row, col}
  local pos = vim.api.nvim_win_get_position(win_id)

  -- Screen dimensions
  -- local total_width = vim.o.columns
  -- local total_height = vim.o.lines

  local is_top = pos[1] == 1
  -- local is_left = pos[2] == 0
  -- local is_bottom = pos[1] + 1 >= total_height - vim.api.nvim_win_get_height(win_id)
  -- local is_right = pos[2] >= total_width - vim.api.nvim_win_get_width(win_id)

  if is_split() and is_top then
    vim.cmd "bp|bd #"
  else
    vim.cmd "bd"
  end
end

vim.keymap.set("n", "<leader>w", smart_delete_buffer, {  noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", smart_delete_buffer, {  noremap = true, silent = true })
