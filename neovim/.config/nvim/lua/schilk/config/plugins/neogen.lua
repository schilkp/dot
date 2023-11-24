local M = {}

function M.config()
    require('neogen').setup {}
    vim.keymap.set({ 'n' }, '<leader>d', require('neogen').generate,
        { silent = true, desc = "📝 Generate Documentation" })
end

return M
