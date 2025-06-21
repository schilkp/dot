local M = {}

function M.config()
	-- Call plugin setup:
	require("copilot").setup({
		panel = {
			enabled = false,
		},
		suggestion = {
			enabled = true,
			auto_trigger = false,
			hide_during_completion = true,
			debounce = 75,
			trigger_on_accept = true,
			keymap = {
				accept = "<M-l>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<M-k>",
			},
		},
		filetypes = {
			["."] = true,
		},
		should_attach = function(_, _)
			return false
		end,
	})

	-- If `blink` menu is visible, hide suggestions:
	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuOpen",
		callback = function()
			vim.b.copilot_suggestion_hidden = true
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuClose",
		callback = function()
			vim.b.copilot_suggestion_hidden = false
		end,
	})

	vim.keymap.set({ "n" }, "<leader>tM", ":Copilot! attach<CR>", { silent = false, desc = "🤖 Copilot: Attach" })
	vim.keymap.set(
		{ "n" },
		"<leader>tm",
		":Copilot suggestion toggle_auto_trigger<CR>",
		{ silent = true, desc = "🤖 Copilot: Toggle Auto Trigger" }
	)
end

---@type LazyPluginSpec
M.spec = {
	"zbirenbaum/copilot.lua",
	config = M.config,
	cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
