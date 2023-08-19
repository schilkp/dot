local M = {}

function M.config()
    local wk = require("which-key")

    -- Document binding categories and bindings from vimrc:
    wk.register({
        f = {
            name = "🔍 Find",
        },
        g = {
            name = "🖥️ LSP",
        },
        s = {
            name = "❗ Spelling",
        },
        a = "Select All.",
        w = "Save.",
        W = "Save All.",
        R = "Reload.",
        x = "Toggle Checkbox.",
        h = "Highlight word under cursor.",
        ["/"] = "Clear highlighting.",
    }, { prefix = "<leader>" })
end

return M
