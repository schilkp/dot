local M = {}

function M.config_highlight_on_yank()
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank({ timeout = 40 })
        end,
        group = highlight_group,
        pattern = '*',
    })
end

function M.config_floatterm_replacement()
    vim.keymap.set({ 'n' }, '<leader>tt', ':vsplit | terminal <CR>', { silent = true, desc = "Open terminal split." })
end

return M
