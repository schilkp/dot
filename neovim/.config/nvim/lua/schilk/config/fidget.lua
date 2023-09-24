local M = {}

function M.config()
    require("fidget").setup({
        text = { spinner = "dots_snake" },
        window = { blend = 0 }
    });
end

return M
