local M = {}

function M.visual_process_selection(processing_func)
  return function()
    -- Retrieve selected lines:
    local pos1 = vim.fn.getpos("v")
    local pos2 = vim.fn.getpos(".")
    local lines = vim.fn.getregion(pos1, pos2, { type = "V" })

    -- Process selected lines using the provided function:
    local processed_lines = processing_func(lines)

    -- Determine buffer and (ordered) line range selected for replacement:
    local bufn = vim.api.nvim_get_current_buf()
    local line_first = math.min(pos1[2], pos2[2])
    local line_last = math.max(pos1[2], pos2[2])

    -- Replace selected lines:
    vim.api.nvim_buf_set_lines(bufn, line_first - 1, line_last, false, processed_lines)

    -- Exit visual mode:
    local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(keys, "m", false)
  end
end

function M.cmd_process_selection(processing_func)
  return function(opts)
    -- Get the range from the command (line1 and line2 are 1-indexed)
    local line_start = opts.line1
    local line_end = opts.line2

    -- Retrieve selected lines (nvim_buf_get_lines uses 0-indexed, exclusive end)
    local bufn = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufn, line_start - 1, line_end, false)

    -- Process selected lines using the provided function
    local processed_lines = processing_func(lines)

    -- Replace selected lines (nvim_buf_set_lines uses 0-indexed)
    vim.api.nvim_buf_set_lines(bufn, line_start - 1, line_end, false, processed_lines)
  end
end

return M
