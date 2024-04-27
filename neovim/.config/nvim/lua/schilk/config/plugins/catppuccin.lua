local M = {}

function M.config()
    require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
    })
    vim.cmd.colorscheme 'catppuccin'
end

return M
