local M = {}

function M.config()
    require('colorizer').setup({})
    
    vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { silent = true, desc = " 🎨 Toggle colorizer." })
end

return M
