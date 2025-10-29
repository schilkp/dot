local M = {}

function M.visual_process_selection(processing_func)
  return function()
    -- Determine range of lines selected:
    local vstart = vim.fn.getpos("v")
    local vcurrent = vim.fn.getcurpos()
    local bufn = vstart[1]
    local line_start = vstart[2]
    local line_current = vcurrent[2]

    local line_first = line_start
    local line_last = line_current
    if line_start > line_current then
      line_first = line_current
      line_last = line_start
    end

    -- Retrieve selected lines:
    local lines = vim.fn.getline(line_first, line_last)

    -- Process selected lines using the provided function:
    local processed_lines = processing_func(lines)

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

    -- Get current buffer
    local bufn = vim.api.nvim_get_current_buf()

    -- Retrieve selected lines (nvim_buf_get_lines uses 0-indexed, exclusive end)
    local lines = vim.api.nvim_buf_get_lines(bufn, line_start - 1, line_end, false)

    -- Process selected lines using the provided function
    local processed_lines = processing_func(lines, opts)

    -- Replace selected lines (nvim_buf_set_lines uses 0-indexed)
    vim.api.nvim_buf_set_lines(bufn, line_start - 1, line_end, false, processed_lines)
  end
end

return M
