local M = {}

M.spec = {
    'Bekaboo/dropbar.nvim',
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
