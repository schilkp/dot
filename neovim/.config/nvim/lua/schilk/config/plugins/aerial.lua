local M = {}

function M.config()
    require("aerial").setup({
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        layout = {
            min_width = 15,
        }
    })
    vim.keymap.set({ 'n' }, '<leader>mo', '<cmd>AerialToggle!<CR>', { silent = true, desc = " 📋 Toggle Outline." }) -- TODO make saga?
end

return M
