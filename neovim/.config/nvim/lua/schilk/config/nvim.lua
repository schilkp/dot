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
    local function open_term_tab()
        vim.cmd("tabnew")
        vim.cmd("terminal")
    end
    vim.keymap.set({ 'n' }, '<leader>tt', open_term_tab, { silent = true, desc = "Open terminal tab." })
end

return M
