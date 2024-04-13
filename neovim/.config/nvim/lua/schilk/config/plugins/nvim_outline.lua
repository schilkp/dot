local M = {}

function M.config()
    require('outline').setup({
        keymaps = {
            close = {},
        },
        outline_window = {
            width = 15,
        }
    })
    vim.keymap.set({ 'n' }, '<leader>mo', '<cmd>Outline<CR>', { silent = true, desc = " 📋 Toggle Outline." }) -- TODO make saga?
end

return M
