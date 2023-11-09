local M = {}

function M.config()
    require('ibl').setup({
        scope = {
            show_start = false,
            show_end = false,
        }
    })
end

return M
