vim.api.nvim_create_autocmd("StdinReadPost", {
	callback = function()
		-- Contains "file format" in first ten lines
		local first_two_lines = table.concat(vim.api.nvim_buf_get_lines(0, 0, 2, false), "\n")
		if not first_two_lines or not string.find(first_two_lines, "file format") then
			return
		end

		-- Contains "Disassmebly of section" in first ten lines
		local first_ten_lines = table.concat(vim.api.nvim_buf_get_lines(0, 0, 10, false), "\n")
		if not first_ten_lines or not string.find(first_ten_lines, "Disassembly of section") then
			return
		end

        vim.notify("stdin heuristics: objdump")

		vim.bo.filetype = "objdump"
	end,
})
