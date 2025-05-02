local M = {}

function M.config()
    vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)', { silent = true, desc = "EasyAlign", remap = true })
end

---@type LazyPluginSpec
M.spec = {
    'junegunn/vim-easy-align',
    config = M.config,
}

return M
