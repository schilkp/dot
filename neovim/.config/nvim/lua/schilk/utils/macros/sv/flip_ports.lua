local M = {}

local utils = require("schilk.utils.macros.utils")

function M.flip_input_output(lines)
	local result = {}

	for _, line in ipairs(lines) do
		local modified_line = line

		-- Check if line contains input or output (ignoring leading whitespace)
		local trimmed = line:match("^%s*(.-)%s*$")

		if trimmed:match("^input%s") then
			-- Replace input with output
			modified_line = line:gsub("(%s*)input(%s)", "%1output%2")
			modified_line = modified_line:gsub("_i(%s*[,%s])", "_o%1")
			modified_line = modified_line:gsub("_i$", "_o")
			modified_line = modified_line:gsub("_ni(%s*[,%s])", "_no%1")
			modified_line = modified_line:gsub("_ni$", "_no")
		elseif trimmed:match("^output%s") then
			-- Replace output with input
			modified_line = line:gsub("(%s*)output(%s)", "%1input%2")
			modified_line = modified_line:gsub("_o(%s*[,%s])", "_i%1")
			modified_line = modified_line:gsub("_o$", "_i")
			modified_line = modified_line:gsub("_no(%s*[,%s])", "_ni%1")
			modified_line = modified_line:gsub("_no$", "_ni")
		end

		table.insert(result, modified_line)
	end

	return result
end

function M.setup()
	vim.keymap.set("v", "gF", utils.visual_process_selection(M.flip_input_output))
	vim.api.nvim_create_user_command(
		"SvFlipPorts",
		utils.cmd_process_selection(M.flip_input_output),
		{ range = true, desc = "Flip SV port directions" }
	)
end

return M
