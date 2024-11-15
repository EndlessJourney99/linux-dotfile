local quote_selector = function()
  -- Search for text inside single or double quotes
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col "." - 1 -- Get current cursor column (0-indexed)
  local left_quote, right_quote

  -- Search leftward for the nearest quote
  for i = col, 1, -1 do
    local char = line:sub(i, i)
    if char == '"' or char == "'" then
      left_quote = i
      break
    end
  end

  if not left_quote then
    -- Search rightward for the nearest quote
    for i = col + 1, #line do
      local char = line:sub(i, i)
      if char == '"' or char == "'" then
        left_quote = i
        break
      end
    end
  end

  if left_quote > col then
    col = left_quote
  end

  -- Search rightward for the matching quote
  if left_quote then
    local quote_char = line:sub(left_quote, left_quote)
    for i = col + 1, #line do
      local char = line:sub(i, i)
      if char == quote_char then
        right_quote = i
        break
      end
    end
  end

  return left_quote, right_quote
end

local visual_select_inner = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, visually select the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote })
    vim.cmd "normal v"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 2 })
  end
end


local yank_inner_quote = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, visually select the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote })
    vim.cmd "normal v"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 2 })
    vim.cmd "normal y"
  end
end

local quote_change_inner = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, change the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote })
    vim.cmd "normal v"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 2 })
    vim.cmd "normal c"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", vim.fn.col "." })
    vim.api.nvim_command("startinsert")
  end
end


local quote_delete_inner = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, delete the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote })
    vim.cmd "normal vi"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 2 })
    vim.cmd "normal d"
  end
end

-- arroud
local visual_select_arround = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, visually select the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote - 1 })
    vim.cmd "normal v"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 1 })
  end
end


local yank_arround_quote = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, visually select the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote - 1 })
    vim.cmd "normal v"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 1 })
    vim.cmd "normal y"
  end
end

local quote_change_arround = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, change the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote - 1 })
    vim.cmd "normal vi"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 1 })
    vim.cmd "normal c"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", vim.fn.col "." })
    vim.api.nvim_command("startinsert")
  end
end

local quote_delete_arround = function()
  local left_quote, right_quote = quote_selector()

  -- If we found both quotes, delete the text inside them
  if left_quote and right_quote then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", left_quote - 1 })
    vim.cmd "normal vi"
    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", right_quote - 1 })
    vim.cmd "normal d"
  end
end
-- keybinding
vim.keymap.set("n", "viq", "", { noremap = true, callback = visual_select_inner })
vim.keymap.set("n", "ciq", "", { noremap = true, callback = quote_change_inner })
vim.keymap.set("n", "diq", "", { noremap = true, callback = quote_delete_inner })
vim.keymap.set("n", "yiq", "", { noremap = true, callback = yank_inner_quote })

vim.keymap.set("n", "vaq", "", { noremap = true, callback = visual_select_arround })
vim.keymap.set("n", "caq", "", { noremap = true, callback = quote_change_arround })
vim.keymap.set("n", "daq", "", { noremap = true, callback = quote_delete_arround })
vim.keymap.set("n", "yaq", "", { noremap = true, callback = yank_arround_quote })
