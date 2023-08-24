local M = {}

local SV_IDENTIFIER_PATTERN = "[%a_][%a_%$%d]*"

function M.sperate_comment(line)
    local idx, _ = line:find("//")
    if (idx ~= nil) then
        local comment = string.sub(line, idx)
        local line_content = string.sub(line, 0, idx - 1)
        return line_content, comment
    end

    local idx_start, _ = line:find("/%*")
    local idx_end, _ = line:find("%*/")
    if (idx_start ~= nil and idx_end ~= nil) then
        local comment = string.sub(line, idx_start, idx_end)
        local line_content = string.sub(line, 0, idx_start - 1) .. string.sub(line, idx_end + 1)
        return line_content, comment
    end

    return line, ""
end

function M.process_parameter_line(orig_line)
    -- Parameter line.
    local line = orig_line

    -- Remove indentation:
    line = line:gsub("^%s*", "")

    -- Seperate comment:
    local content, comment = M.sperate_comment(orig_line)
    line = content

    -- Seperate trailing comma:
    local trailing_comma = ""
    local idx_comma, _ = line:find(",")
    if (idx_comma ~= nil) then
        trailing_comma = ","
        line = string.sub(line, 0, idx_comma - 1)
    end

    -- Strip default value:
    local idx_eq, _ = line:find("=")
    if (idx_eq ~= nil) then
        line = string.sub(line, 0, idx_eq - 1)
    end

    -- Isolate identifier:
    local ident_start, indent_stop = line:find(SV_IDENTIFIER_PATTERN .. "%s*$")
    if (ident_start ~= nil and indent_stop ~= nil) then
        local identifier = string.sub(line, ident_start, indent_stop)
        identifier = string.gsub(identifier, "%s", "")
        return "  ." .. identifier .. "( )" .. trailing_comma .. comment
    else
        -- Failed to grab identifier. Return orig string.
        return orig_line
    end
end

function M.process_input_output_line(orig_line, line_without_io)
    -- input/output line.
    local line = line_without_io

    -- Remove indentation:
    line = line:gsub("^%s*", "")

    -- Seperate comment:
    local content, comment = M.sperate_comment(orig_line)
    line = content

    -- Seperate trailing comma:
    local trailing_comma = ""
    local idx_comma, _ = line:find(",")
    if (idx_comma ~= nil) then
        trailing_comma = ","
        line = string.sub(line, 0, idx_comma - 1)
    end

    -- Remove trailing array indices:
    line = line:gsub("%[.*%]%s*$", "")

    -- Isolate identifier:
    local ident_start, indent_stop = line:find(SV_IDENTIFIER_PATTERN .. "%s*$")
    if (ident_start ~= nil and indent_stop ~= nil) then
        local identifier = string.sub(line, ident_start, indent_stop)
        identifier = string.gsub(identifier, "%s", "")
        return "  ." .. identifier .. "( )" .. trailing_comma .. comment
    else
        -- Failed to grab identifier. Return orig string.
        return orig_line
    end
end

function M.convert_to_instantiation(inp)
    local result = {}

    for _, line in ipairs(inp) do
        if (line:find("^%s*parameter") ~= nil) then
            local processed_line = M.process_parameter_line(line)
            table.insert(result, processed_line)
        elseif (line:find("^%s*input") ~= nil) then
            local _, idx_end = line:find("^%s*input")
            local processed_line = line:sub(idx_end + 1)
            processed_line = M.process_input_output_line(line, processed_line)
            table.insert(result, processed_line)
        elseif (line:find("^%s*output") ~= nil) then
            local _, idx_end = line:find("^%s*output")
            local processed_line = line:sub(idx_end + 1)
            processed_line = M.process_input_output_line(line, processed_line)
            table.insert(result, processed_line)
        else
            table.insert(result, line)
        end
    end

    return result
end

function M.convert_selection()
    -- Determine range of lines selected:
    local vstart = vim.fn.getpos("v")
    local vcurrent = vim.fn.getcurpos()
    local bufn = vstart[1]
    local line_start = vstart[2]
    local line_current = vcurrent[2]

    local line_first = line_start
    local line_last = line_current
    if (line_start > line_current) then
        line_first = line_current
        line_last = line_start
    end

    -- Retrieve selected lines:
    local lines = vim.fn.getline(line_first, line_last)

    -- Process selected lines:
    local processed_lines = M.convert_to_instantiation(lines)

    -- Replace selected lines:
    vim.api.nvim_buf_set_lines(bufn, line_first - 1, line_last, false, processed_lines)

    -- Exit visual mode:
    local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(keys, 'm', false)

end

function M.setup()
    -- local sv_shortcut_group = vim.api.nvim_create_augroup('SchilkSV', { clear = true })
    -- local function map_convert()
    --     -- vim.keymap.set("v", "gm", M.convert_selection, {})
    --     vim.print("WTF")
    -- end
    -- vim.api.nvim_create_autocmd('FileType', {
    --     callback = function()
    --         vim.keymap.set("v", "gm", map_convert, { Desc = "Convert" })
    --     end,
    --     group = sv_shortcut_group,
    --     pattern = 'verilog,systemverilog',
    -- })
    vim.keymap.set("v", "gm", M.convert_selection)
end

return M
