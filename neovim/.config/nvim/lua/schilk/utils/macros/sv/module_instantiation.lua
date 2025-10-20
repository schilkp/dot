local M = {}

local sv_utils = require("schilk.utils.macros.sv.utils")
local utils = require("schilk.utils.macros.utils")

function M.process_parameter_line(orig_line)
	-- Parameter line.
	local line = orig_line

	-- Remove indentation:
	line = line:gsub("^%s*", "")

	-- Seperate comment:
	local content, comment = sv_utils.sperate_comment(orig_line)
	line = content

	-- Seperate trailing comma:
	local trailing_comma = ""
	local idx_comma, _ = line:find(",")
	if idx_comma ~= nil then
		trailing_comma = ","
		line = string.sub(line, 0, idx_comma - 1)
	end

	-- Strip default value:
	local idx_eq, _ = line:find("=")
	if idx_eq ~= nil then
		line = string.sub(line, 0, idx_eq - 1)
	end

	-- Isolate identifier:
	local ident_start, indent_stop = line:find(sv_utils.SV_IDENTIFIER_PATTERN .. "%s*$")
	if ident_start ~= nil and indent_stop ~= nil then
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
	local content, comment = sv_utils.sperate_comment(orig_line)
	line = content

	-- Seperate trailing comma:
	local trailing_comma = ""
	local idx_comma, _ = line:find(",")
	if idx_comma ~= nil then
		trailing_comma = ","
		line = string.sub(line, 0, idx_comma - 1)
	end

	-- Remove trailing array indices:
	line = line:gsub("%[.*%]%s*$", "")

	-- Isolate identifier:
	local ident_start, indent_stop = line:find(sv_utils.SV_IDENTIFIER_PATTERN .. "%s*$")
	if ident_start ~= nil and indent_stop ~= nil then
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
		if line:find("^%s*parameter") ~= nil then
			local processed_line = M.process_parameter_line(line)
			table.insert(result, processed_line)
		elseif line:find("^%s*input") ~= nil then
			local _, idx_end = line:find("^%s*input")
			local processed_line = line:sub(idx_end + 1)
			processed_line = M.process_input_output_line(line, processed_line)
			table.insert(result, processed_line)
		elseif line:find("^%s*output") ~= nil then
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

function M.setup()
	vim.keymap.set("v", "gm", utils.visual_process_selection(M.convert_to_instantiation))
end

return M
