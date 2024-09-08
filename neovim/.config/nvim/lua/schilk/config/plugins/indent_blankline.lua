local M = {}

function M.config()
    require('ibl').setup({
        scope = {
            show_start = false,
            show_end = false,
        }
    })
end

M.spec = {
    "lukas-reineke/indent-blankline.nvim",
    config = M.config,
}

return M
