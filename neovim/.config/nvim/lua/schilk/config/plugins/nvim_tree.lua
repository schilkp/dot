local M = {}

function M.config()
    require('nvim-tree').setup({
        view = {
            width = "15%"
        }
    })
    vim.keymap.set({ 'n' }, '<leader>q', ':NvimTreeToggle<CR>', { silent = true, desc = "🌳 Toggle File Tree." }) -- TODO make saga?
end

M.spec = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = M.config
}

return M
