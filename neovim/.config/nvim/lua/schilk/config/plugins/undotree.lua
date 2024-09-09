local M = {}

function M.config()
    vim.keymap.set({ 'n' }, '<leader>mu', ':UndotreeToggle<CR>', { silent = true, desc = "📝 Toggle Undotree." })
end

M.spec = {
    "mbbill/undotree",
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
