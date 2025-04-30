local M = {}

M.spec = {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        image = {
        }
    },
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
