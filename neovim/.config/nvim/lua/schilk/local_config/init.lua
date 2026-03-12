local M = {}

--//===--------------------------------------------------------------------===//
--// Config Constants
--//===--------------------------------------------------------------------===//

M.CONFIG_FILE_NAMES = { ".schilk.nvim.lua" }
M.CONFIG_SAMPLES_DIR = vim.fs.joinpath(vim.fn.stdpath("config"), "example_local_configs")

--//===--------------------------------------------------------------------===//
--// Commands
--//===--------------------------------------------------------------------===//

function M.copy_to_samples()
  local filename = vim.fn.expand("%:p")

  if vim.fn.isdirectory(M.CONFIG_SAMPLES_DIR) == 0 then
    vim.fn.mkdir(M.CONFIG_SAMPLES_DIR, "p")
  end

  -- Prompt user for sample name
  vim.ui.input({
    prompt = "Enter sample name: ",
  }, function(name)
    if not name or name == "" then
      vim.notify("Sample name is required", vim.log.levels.WARN)
      return
    end

    local dest = M.CONFIG_SAMPLES_DIR .. "/" .. name .. ".lua"
    local result = vim.fn.writefile(vim.fn.readfile(filename), dest)

    if result == 0 then
      vim.notify("File copied to " .. dest, vim.log.levels.INFO)
    else
      vim.notify("Failed to copy file", vim.log.levels.ERROR)
    end
  end)
end

---Edit local configuration
--- @param filename? string: a file name
function M.edit(filename)
  filename = filename or M.lookup() or M.CONFIG_FILE_NAMES[1]
  vim.api.nvim_command("edit " .. filename)
end

---Look for config file
function M.lookup()
  for _, filename in ipairs(M.CONFIG_FILE_NAMES) do
    filename = vim.fn.findfile(filename, ".;")
    if filename ~= "" then
      return vim.fn.fnamemodify(filename, ":p")
    end
  end
end

local function defer_notif(msg, level)
  vim.defer_fn(function()
    vim.notify(msg, level)
  end, 250)
end

--Look for config file & source if trusted
function M.source()
  local file = M.lookup()
  if not file or file == "" then
    return
  end

  local content = vim.secure.read(file) --[[@as string|nil]]
  if not content then
    defer_notif("[local_config]: local config file found but not trusted!", vim.log.levels.WARN)
    return
  end

  local config_fn, err_load = loadstring(content, "@" .. file)
  if not config_fn then
    defer_notif("[local_config]: failed to load local config file: " .. err_load, vim.log.levels.ERROR)
    return
  end

  local success, err_call = pcall(config_fn)
  if not success then
    defer_notif("[local_config]: failed to load local config file: " .. err_call, vim.log.levels.ERROR)
    return
  end

  local msg = "[local_config]: loaded local config file"
  _G.SCHILK_LOCAL_NOTE = _G.SCHILK_LOCAL_NOTE or nil --[[@as string|nil]]
  if _G.SCHILK_LOCAL_NOTE then
    msg = msg .. " (" .. _G.SCHILK_LOCAL_NOTE .. ")."
  else
    msg = msg .. "."
  end
  defer_notif(msg, vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_command("command! LocalEdit lua require'schilk.local_config'.edit()<CR>")
  vim.api.nvim_command("command! LocalSaveAsSample lua require'schilk.local_config'.copy_to_samples()<CR>")
end

return M
