local M = {}

M.SV_IDENTIFIER_PATTERN = "[%a_][%a_%$%d]*"

function M.separate_comment(line)
  local idx, _ = line:find("//")
  if idx ~= nil then
    local comment = string.sub(line, idx)
    local line_content = string.sub(line, 1, idx - 1)
    return line_content, comment
  end

  local idx_start, _ = line:find("/%*")
  local idx_end, _ = line:find("%*/")
  if idx_start ~= nil and idx_end ~= nil then
    local comment = string.sub(line, idx_start, idx_end + 1)
    local line_content = string.sub(line, 1, idx_start - 1) .. string.sub(line, idx_end + 2)
    return line_content, comment
  end

  return line, ""
end

return M
