local M = {}

function M.config()
    require('nvim-tree').setup()
    vim.keymap.set({ 'n' }, '<leader><space>', ':NvimTreeToggle<CR>', { silent = true, desc = "Toggle File Tree." }) -- TODO make saga?
end

return M
