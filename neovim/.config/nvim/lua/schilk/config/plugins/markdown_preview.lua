local M = {}

function M.config()
    vim.api.nvim_create_autocmd('FileType', {
        desc = 'Markdown preview keybinds',
        pattern = 'markdown',
        group = vim.api.nvim_create_augroup('md_keybidn', { clear = true }),
        callback = function(opts)
            vim.keymap.set({ 'n' }, '<leader>ll', ':MarkdownPreviewToggle<CR>',
                { silent = true, desc = "📝 Toggle Markdown Preview", buffer = true })
        end,
    })
end

return M
