local M = {}

---@type LazyPluginSpec
M.spec = {
    'folke/trouble.nvim',
    opts = {
        max_items = 10000,
    },
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
