local M = {}

function M.config()
    vim.api.nvim_create_autocmd('FileType', {
        desc = 'Markdown preview keybinds',
        pattern = 'markdown',
        group = vim.api.nvim_create_augroup('md_keybind', { clear = true }),
        callback = function(opts)
            vim.keymap.set({ 'n' }, '<leader>ll', ':MarkdownPreviewToggle<CR>',
                { silent = true, desc = "📝 Toggle Markdown Preview", buffer = true })
        end,
    })
end

M.spec = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = M.config
}

return M
