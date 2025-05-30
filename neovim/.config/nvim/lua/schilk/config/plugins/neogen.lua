local M = {}

function M.config()
    require('neogen').setup {}
    vim.keymap.set({ 'n' }, '<leader>td', require('neogen').generate, { silent = true, desc = "📝 Generate Documentation" })
end

---@type LazyPluginSpec
M.spec = {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = M.config,
}

return M
