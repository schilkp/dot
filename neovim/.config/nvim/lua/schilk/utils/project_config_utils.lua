local M = {}

function M.get_local_config_path(p)
  -- Remove '@` prefix if it exists
  if p:sub(1, 1) == "@" then
    return p:sub(2)
  else
    return p
  end
end

function M.get_local_config_dir(p)
  return vim.fn.fnamemodify(M.get_local_config_path(p), ":h")
end

return M
