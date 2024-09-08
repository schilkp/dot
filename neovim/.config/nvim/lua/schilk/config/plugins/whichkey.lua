local M = {}

function M.config()
    local wk = require("which-key")

    -- Disable WK automatic icons:
    -- FIXME: Move to this system to not loose pre-defined/default icons, espc for plugins?
    wk.setup({
        icons = {
            mappings = false,
        }
    })

    -- Document binding categories and bindings from vimrc:
    wk.add({
        { "<leader>/", desc = "🔦 Clear Highlighting." },
        { "<leader>R", desc = "♻️ Reload." },
        { "<leader>W", desc = "💾 Save All." },
        { "<leader>a", desc = "🔦 Select All." },
        { "<leader>f", group = "🔍 Find..." },
        { "<leader>g", group = "🖥️ LSP..." },
        { "<leader>h", desc = "🔦 Highlight Word Under Cursor." },
        { "<leader>m", group = "🔧 Modes.." },
        { "<leader>s", group = "❗ Spelling..." },
        { "<leader>w", desc = "💾 Save." },
        { "<leader>x", desc = "✅ Toggle Checkbox." },
    }, { prefix = "<leader>" })
end

M.spec = {
    'folke/which-key.nvim',
    config = M.config
}

return M
