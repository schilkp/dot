local M = {}

local org_roam_config = require("schilk.config.plugins.orgmode")

--- Export + Open as HTML (for copy-paste to email)
function M.to_html()
  -- absolute path:
  local current_file = vim.fn.expand("%:p")

  -- Sanity/error checks:
  if current_file == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("pandoc") == 0 then
    vim.notify("pandoc is not available in PATH", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("firefox") == 0 then
    vim.notify("firefox is not available in PATH", vim.log.levels.ERROR)
    return
  end

  -- Run pandoc
  local pandoc_cmd = {
    "pandoc",
    "--embed-resources",
    "--standalone",
    "--mathml",
    "--variable",
    "maxwidth=60em",
    current_file,
    "-o",
    "/tmp/roam.html",
  }
  local pandoc_result = vim.system(pandoc_cmd, { cwd = vim.fn.expand(org_roam_config.org_roam_dir) }):wait()
  if pandoc_result.code ~= 0 then
    vim.notify("Pandoc conversion failed: " .. (pandoc_result.stderr or ""), vim.log.levels.ERROR)
    return
  end

  -- Open in firefox
  vim.system({ "firefox", "/tmp/roam.html" })
  vim.notify("Opening HTML..", vim.log.levels.INFO)
end

return M
