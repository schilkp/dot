local M = {}

M.spec = {
    'folke/trouble.nvim',
    opts = {},
    lazy = true,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
    keys = {
        {
            "<leader>gH",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "LSP: Open Diagnostics Pane"
        }
    }
}

return M
