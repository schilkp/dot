local M = {}

function M.config()
    vim.keymap.set({ 'n' }, '<leader>mu', ':UndotreeToggle<CR>', { silent = true, desc = "📝 Toggle Undotree." })
end

return M
