local M = {}

function M.config()
    require('nvim-tree').setup({
        view = {
            width = "15%"
        }
    })
    vim.keymap.set({ 'n' }, '<leader>q', ':NvimTreeToggle<CR>', { silent = true, desc = "🌳 Toggle File Tree." }) -- TODO make saga?
end

---@type LazyPluginSpec
M.spec = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
