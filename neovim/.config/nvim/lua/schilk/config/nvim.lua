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

function M.config_no_jk_mapping_trainig()
    local function NO()
        vim.api.nvim_err_writeln("NO!");
    end
    vim.keymap.set("i", "jk", NO);
end

M.py_env_dir = vim.fs.normalize('~/.config/nvim/nvim_env')
M.py = vim.fs.normalize(M.py_env_dir .. '/bin/python')

function M.config_py3_env()
    if (vim.fn.filereadable(M.py) == 1) then
        -- Venv exists: Use it
        vim.g.python3_host_prog = M.py
    else
        -- Venv does not exist. Try to create it:
        vim.print("No NVIM py3 venv exists. Call `require('schilk.config.nvim').create_py3_env()`.")
    end
end

function M.create_py3_env()
    if (vim.fn.filereadable(M.py) == 1) then
        vim.print("NVIM py3 venv already exists.")
        return
    end

    local e = os.execute('python3 -m venv "' .. M.py_env_dir .. '" 1>/dev/null 2>/dev/null')
    if (e ~= 0) then
        vim.print("Unabled to create.")
        return
    end

    e = os.execute(M.py .. ' -m pip install pynvim 1>/dev/null 2>/dev/null')
    if (e ~= 0) then
        vim.print("Unable to install pynvim in venv!")
        return
    end

    vim.print("NVIM py3 venv created.")
    vim.g.python3_host_prog = M.py
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
