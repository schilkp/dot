local M = {}

M.spec = {
    'folke/trouble.nvim',
    opts = {},
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
