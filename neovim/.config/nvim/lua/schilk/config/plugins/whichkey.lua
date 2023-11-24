local M = {}

function M.config()
    local wk = require("which-key")

    -- Document binding categories and bindings from vimrc:
    wk.register({
        f = {
            name = "🔍 Find...",
        },
        g = {
            name = "🖥️ LSP...",
        },
        s = {
            name = "❗ Spelling...",
        },
        m = {
            name = "🔧 Modes..",
        },
        a = "🔦 Select All.",
        w = "💾 Save.",
        W = "💾 Save All.",
        R = "♻️  Reload.",
        x = "✅ Toggle Checkbox.",
        h = "🔦 Highlight Word Under Cursor.",
        ["/"] = "🔦 Clear Highlighting.",
    }, { prefix = "<leader>" })
end

return M
