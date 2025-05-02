local M = {}

function M.config()
    require('colorizer').setup({})

    vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { silent = true, desc = "🎨 Toggle colorizer." })
end

---@type LazyPluginSpec
M.spec = {
    "norcalli/nvim-colorizer.lua",
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
