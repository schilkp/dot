local M = {}

M.spec = {
    "utilyre/barbecue.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
