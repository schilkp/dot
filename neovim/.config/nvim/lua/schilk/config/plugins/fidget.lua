local M = {}

function M.config()
    require("fidget").setup({
        text = { spinner = "dots_snake" },
        window = { blend = 0 },
        sources = {
            ltex = {
                ignore = true
            }
        }
    });
end

return M
