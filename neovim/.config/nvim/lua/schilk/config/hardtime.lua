local M = {}

function M.config()
    local function toggle_hardtime()
        -- Possible once PR merged..
        -- if (not require('hardtime').is_enabled()) then
        --     vim.print("Enabling hardtime..")
        --     require('hardtime').enable()
        -- else
        --     vim.print("Disabling hardtime..")
        --     require('hardtime').disable()
        -- end
        vim.print("Toggling hardtime..")
        require('hardtime').toggle()
    end
    require('hardtime').setup({
        enabled = false
    })
    -- default enable seems to be broken maybe? Too lazy to debug.
    vim.keymap.set({ 'n' }, '<leader>mh', toggle_hardtime, { silent = true, desc = "😠 Toggle hardtime." })
end

return M
