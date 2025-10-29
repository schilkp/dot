local M = {}

---@type LazyPluginSpec
M.spec = {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
  },
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
