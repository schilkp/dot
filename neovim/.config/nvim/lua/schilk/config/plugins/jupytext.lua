local M = {}

---@type LazyPluginSpec
M.spec = {
	"goerz/jupytext.nvim",
	config = M.config,
	opts = {
		format = "script",
        filetype = "python",
	},
	cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
