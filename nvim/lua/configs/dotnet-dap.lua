local M = {}

local number_indices = function(array)
  local result = {}
  for i, value in ipairs(array) do
    result[i] = i .. ": " .. value
  end
  return result
end

local display_options = function(prompt_title, options)
  options = number_indices(options)
  table.insert(options, 1, prompt_title)

  local choice = vim.fn.inputlist(options)

  if choice > 0 then
    return options[choice + 1]
  else
    return nil
  end
end

local file_selection = function(cmd, opts)
  local results = vim.fn.systemlist(cmd)

  if #results == 0 then
    print(opts.empty_message)
    return
  end

  if opts.allow_multiple then
    return results
  end

  local result = results[1]
  if #results > 1 then
    result = display_options(opts.multiple_title_message, results)
  end

  return result
end

local project_selection = function(project_path, allow_multiple)
  local check_csproj_cmd = string.format('find %s -type f -name "*.csproj"', project_path)
  local project_file = file_selection(check_csproj_cmd, {
    empty_message = "No csproj files found in " .. project_path,
    multiple_title_message = "Select project:",
    allow_multiple = allow_multiple,
  })
  return project_file
end

local smart_pick_process = function(dap_utils, project_path)
  local project_file = project_selection(project_path, true)
  if project_file == nil then
    return
  end

  local filter = function(proc)
    if type(project_file) == "table" then
      for _, file in pairs(project_file) do
        local project_name = vim.fn.fnamemodify(file, ":t:r")
        if vim.endswith(proc.name, project_name) then
          return true
        end
      end
      return false
    elseif type(project_file) == "string" then
      local project_name = vim.fn.fnamemodify(project_file, ":t:r")
      return vim.startswith(proc.name, project_name or "dotnet")
    end
  end

  local processes = dap_utils.get_processes()
  processes = vim.tbl_filter(filter, processes)

  if #processes == 0 then
    print "No dotnet processes could be found automatically. Try 'Attach' instead"
    return
  end

  if #processes > 1 then
    return dap_utils.pick_process {
      filter = filter,
    }
  end

  return processes[1].pid
end
local load_module = function(module_name)
  local ok, module = pcall(require, module_name)
  return module
end

--- Rebuilds the project before starting the debug session
---@param co thread
local function rebuild_project(co, path)
  local spinner = require("easy-dotnet.ui-modules.spinner").new()
  spinner:start_spinner "Building"
  vim.fn.jobstart(string.format("dotnet build %s", path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        spinner:stop_spinner "Built successfully"
      else
        spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
        error "Build failed"
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

M.register_net_dap = function()
  local dap = require "dap"
  local dotnet = require "easy-dotnet"
  local debug_dll = nil
  local dap_utils = load_module "dap.utils"

  local function ensure_dll()
    if debug_dll ~= nil then
      return debug_dll
    end
    local dll = dotnet.get_debug_dll()
    debug_dll = dll
    return dll
  end

  for _, value in ipairs { "cs", "fsharp" } do
    dap.configurations[value] = {
      {
        type = "coreclr",
        name = "Build and Debug",
        request = "launch",
        env = function()
          local dll = ensure_dll()
          local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
          return vars or nil
        end,
        program = function()
          local dll = ensure_dll()
          local co = coroutine.running()
          rebuild_project(co, dll.project_path)
          return dll.relative_dll_path
        end,
        cwd = function()
          local dll = ensure_dll()
          return dll.relative_project_path
        end,
      },
      {
        type = "coreclr",
        name = "Attach",
        request = "attach",
        processId = dap_utils.pick_process,
      },
      {
        type = "coreclr",
        name = "Attach (Smart)",
        request = "attach",
        processId = function()
          local current_working_dir = vim.fn.getcwd()
          return smart_pick_process(dap_utils, current_working_dir) or dap.ABORT
        end,
      },
    }
  end
  -- require("dap-cs").setup {
  --   -- your configuration comes here
  --   dap_configurations = {
  --     {
  --       -- Must be "coreclr" or it will be ignored by the plugin
  --       type = "coreclr",
  --       name = "Attach remote",
  --       mode = "remote",
  --       request = "attach",
  --     },
  --   },
  -- }

  dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
    debug_dll = nil
  end

  dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }
end

return M
