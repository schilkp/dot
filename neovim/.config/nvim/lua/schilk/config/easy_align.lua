local M = {}

function M.config()
    vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)', { silent = true, desc = "EasyAlign", remap = true })
end

return M
