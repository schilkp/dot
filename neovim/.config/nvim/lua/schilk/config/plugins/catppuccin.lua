local M = {}

function M.config()
    require("catppuccin").setup({
        flavour = "frappe",            -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
    })
    vim.cmd.colorscheme 'catppuccin'
end

M.spec = {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
