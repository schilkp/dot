local M = {}

local org_roam_config = require("schilk.config.plugins.orgmode")

function M.new()
  local idx_file = vim.fn.expand(org_roam_config.org_roam_dir) .. "/docupdt_next_idx"

  -- Read next index
  local f = io.open(idx_file, "r")
  if not f then
    vim.notify("[DocUpdt] Could not open " .. idx_file, vim.log.levels.ERROR)
    return
  end
  local raw = f:read("*l")
  f:close()

  local idx = tonumber(vim.trim(raw))
  if not idx then
    vim.notify("[DocUpdt] docupdt_next_idx does not contain a valid number", vim.log.levels.ERROR)
    return
  end

  local padded = string.format("%03d", idx)
  local filename = "DocUpdt_" .. padded .. ".org"
  local filepath = vim.fn.expand(org_roam_config.org_roam_dir) .. "/" .. filename

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
        -- Write incremented index
        local wf = io.open(idx_file, "w")
        if wf then
          wf:write(tostring(idx + 1) .. "\n")
          wf:close()
          vim.notify("[DocUpdt] Created DocUpdt-" .. padded .. ", next index is " .. (idx + 1), vim.log.levels.INFO)
        else
          vim.notify("[DocUpdt] Warning: could not update " .. idx_file, vim.log.levels.WARN)
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

return M
