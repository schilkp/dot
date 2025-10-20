local M = {}

---@type LazyPluginSpec
M.spec = {
    'folke/trouble.nvim',
    opts = {
        max_items = 10000,
        follow = false,
        auto_preview = false,
        preview = {
            scratch = false,
        },
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
