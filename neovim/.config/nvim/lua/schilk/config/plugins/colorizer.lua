local M = {}

function M.config()
    require('colorizer').setup({})

    vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { silent = true, desc = " 🎨 Toggle colorizer." })
end

M.spec = {
    "norcalli/nvim-colorizer.lua",
    config = M.config
}

return M
