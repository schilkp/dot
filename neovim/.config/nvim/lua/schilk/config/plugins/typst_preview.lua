local M = {}

function M.config()
    vim.log("config typst preview")
    require("typst-preview").setup({})
end

M.spec = {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
