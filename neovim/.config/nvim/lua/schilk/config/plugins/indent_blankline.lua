local M = {}

function M.config()
    require('ibl').setup({
        scope = {
            show_start = false,
            show_end = false,
        }
    })
end

---@type LazyPluginSpec
M.spec = {
    "lukas-reineke/indent-blankline.nvim",
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
