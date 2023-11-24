local M = {}

M.py_env_dir = vim.fs.normalize('~/.config/nvim/nvim_env')
M.py = vim.fs.normalize(M.py_env_dir .. '/bin/python')

function M.config_py3_env()
    vim.cmd("command CreatePy3Env lua require('schilk.config.nvim').create_py3_env()")
    if (vim.fn.filereadable(M.py) == 1) then
        -- Venv exists: Use it
        vim.g.python3_host_prog = M.py
    else
        -- Venv does not exist. Try to create it:
        vim.print("No NVIM py3 venv exists. Call `:CreatePy3Env`.")
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

return M
