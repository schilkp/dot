local M = {}

function M.config()
    local function toggle_hardtime()
        if (not require('hardtime').is_enabled) then
            vim.print("Enabling hardtime..")
            require('hardtime').enable()
        else
            vim.print("Disabling hardtime..")
            require('hardtime').disable()
        end
    end
    require('hardtime').setup({
        enabled = false
    })
    -- default enable seems to be broken maybe? Too lazy to debug.
    vim.keymap.set({ 'n' }, '<leader>mh', toggle_hardtime, { silent = true, desc = "😠 Toggle hardtime." })
end

M.spec = {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
