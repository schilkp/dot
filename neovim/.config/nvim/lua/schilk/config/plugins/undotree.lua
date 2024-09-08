local M = {}

function M.config()
    vim.keymap.set({ 'n' }, '<leader>mu', ':UndotreeToggle<CR>', { silent = true, desc = "📝 Toggle Undotree." })
end

M.spec = {
    "mbbill/undotree",
    config = M.config
}

return M
