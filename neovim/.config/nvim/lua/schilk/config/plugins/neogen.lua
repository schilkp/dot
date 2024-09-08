local M = {}

function M.config()
    require('neogen').setup {}
    vim.keymap.set({ 'n' }, '<leader>mg', require('neogen').generate,
        { silent = true, desc = "📝 Generate Documentation" })
end

M.spec = {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = M.config,
}

return M
