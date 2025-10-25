local M = {}

function M.config()
    require("typst-preview").setup({
        port = 9002
    })
    vim.keymap.set({ 'n' }, '<leader>ll', ":TypstPreviewToggle<cr>", { silent = true, desc = "Typst: Preview Toggle." })
    vim.keymap.set({ 'n' }, '<leader>lf', ":TypstPreviewFollowCursorToggle<cr>", { silent = true, desc = "Typst: Follow Cursor Toggle." })
    vim.keymap.set({ 'n' }, '<leader>lv', ":TypstPreviewSyncCursor<cr>", { silent = true, desc = "Typst: Sync Cursor." })
end

---@type LazyPluginSpec
M.spec = {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
