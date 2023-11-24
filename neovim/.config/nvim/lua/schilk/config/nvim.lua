local M = {}

function M.config_highlight_on_yank()
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank({ timeout = 40 })
        end,
        group = highlight_group,
        pattern = '*',
    })
end

function M.config_floatterm_replacement()
    vim.keymap.set({ 'n' }, '<leader>t', ':split | terminal <CR>', { silent = true, desc = "📠 Open Terminal Split." })
end

local large_file_mode = false

-- FIXME: Make this per-buffer? Unlikely I need it enough to be worth it ;)
local function toggle_large_file_mode()
    if (not large_file_mode) then
        vim.print("Entering Large-File-Mode..")
        vim.cmd("syntax off")
        vim.cmd("filetype off")
        vim.cmd("set noundofile")
        vim.cmd("set noloadplugins")
        vim.cmd("set lazyredraw")
        vim.cmd("TSDisable *")
        large_file_mode = true
    else
        vim.print("Exiting Large-File-Mode..")
        vim.cmd("syntax on")
        vim.cmd("filetype on")
        vim.cmd("set undofile")
        vim.cmd("set loadplugins")
        vim.cmd("set nolazyredraw")
        vim.cmd("TSEnable *")
        large_file_mode = false
    end
end

function M.config_large_file_mode()
    vim.keymap.set("n", "<leader>ml", toggle_large_file_mode, { silent = true, desc = "📁 Toggle Large-File-Mode" })
end

return M
