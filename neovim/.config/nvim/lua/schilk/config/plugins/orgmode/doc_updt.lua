local M = {}

M.org_roam_dir = vim.fn.expand(require("schilk.config.plugins.orgmode").org_roam_dir)
M.idx_file_name = "docupdt_next_idx"

function M.new()
  local idx = M.read_idx()
  if not idx then
    return
  end

  local padded = string.format("%03d", idx)
  local filename = "DocUpdt_" .. padded .. ".org"
  local filepath = vim.fs.joinpath(M.org_roam_dir, filename)

  -- Sanity-check: file must not already exist
  if vim.fn.filereadable(filepath) == 1 then
    vim.notify("[DocUpdt] File already exists: " .. filepath, vim.log.levels.ERROR)
    return
  end

  local title = "NEXT DocUpdt-" .. padded

  local roam = require("org-roam")
  roam.api
    .capture_node({
      title = title,
      templates = {
        d = {
          description = "DocUpdt",
          template = "%?",
          target = filename,
        },
      },
    })
    :next(function(id)
      if id then
        -- Write incremented index.
        if M.write_idx(idx + 1) then
          vim.notify("[DocUpdt] Created DocUpdt-" .. padded .. ", next index is " .. (idx + 1), vim.log.levels.INFO)
        end
      end
    end)
end

function M.done()
  local date = os.date("%Y-%m-%d")
  local cmd = string.format("%%s/+TITLE: NEXT DocUpdt-\\(\\d\\d\\d\\)/+TITLE: DocUpdt-\\1 %s/g", date)
  vim.cmd(cmd)
  vim.notify("[DocUpdt] Marked as done.", vim.log.levels.INFO)
end

function M.read_idx()
  local idx_file = vim.fs.joinpath(M.org_roam_dir, M.idx_file_name)
  local f = io.open(idx_file, "r")
  if not f then
    vim.notify("[DocUpdt] Could not open " .. idx_file, vim.log.levels.ERROR)
    return nil
  end
  local raw = f:read("*l")
  f:close()

  local idx = tonumber(vim.trim(raw))
  if not idx then
    vim.notify("[DocUpdt] docupdt_next_idx does not contain a valid number", vim.log.levels.ERROR)
    return nil
  end
  return idx
end

function M.write_idx(idx)
  local idx_file = vim.fs.joinpath(M.org_roam_dir, M.idx_file_name)
  local f = io.open(idx_file, "w")
  if not f then
    vim.notify("[DocUpdt] Warning: could not update " .. idx_file, vim.log.levels.WARN)
    return false
  end
  f:write(tostring(idx) .. "\n")
  f:close()
  return true
end

return M
