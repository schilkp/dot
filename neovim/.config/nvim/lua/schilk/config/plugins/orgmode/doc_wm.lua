local M = {}

local org_roam_config = require("schilk.config.plugins.orgmode")

function M.new()
  local idx_file = vim.fn.expand(org_roam_config.org_roam_dir) .. "/docwm_next_idx"

  -- Read next index
  local f = io.open(idx_file, "r")
  if not f then
    vim.notify("[DocWM] Could not open " .. idx_file, vim.log.levels.ERROR)
    return
  end
  local raw = f:read("*l")
  f:close()

  local idx = tonumber(vim.trim(raw))
  if not idx then
    vim.notify("[DocWM] docwm_next_idx does not contain a valid number", vim.log.levels.ERROR)
    return
  end

  local padded = string.format("%03d", idx)
  local filename = "DocWM_" .. padded .. ".org"
  local filepath = vim.fn.expand(org_roam_config.org_roam_dir) .. "/" .. filename

  -- Sanity-check: file must not already exist
  if vim.fn.filereadable(filepath) == 1 then
    vim.notify("[DocWM] File already exists: " .. filepath, vim.log.levels.ERROR)
    return
  end

  local title = "NEXT DocWM-" .. padded

  local roam = require("org-roam")
  roam.api
    .capture_node({
      title = title,
      templates = {
        d = {
          description = "DocWM",
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
          vim.notify("[DocWM] Created DocWM-" .. padded .. ", next index is " .. (idx + 1), vim.log.levels.INFO)
        else
          vim.notify("[DocWM] Warning: could not update " .. idx_file, vim.log.levels.WARN)
        end
      end
    end)
end

function M.done()
  local date = os.date("%Y-%m-%d")
  local cmd = string.format("%%s/+TITLE: NEXT DocWM-\\(\\d\\d\\d\\)/+TITLE: DocWM-\\1 %s/g", date)
  vim.cmd(cmd)
  vim.notify("[DocWM] Marked as done.", vim.log.levels.INFO)
end

return M
