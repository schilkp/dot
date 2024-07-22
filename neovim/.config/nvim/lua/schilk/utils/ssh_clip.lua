local M = {}

M.clip_file = vim.fs.normalize("~/.ssh_clip.txt");

function M.pull_ssh_clip(server, reg)
    local cmd = "ssh " .. server .. " \"cat ~/.ssh_clip.txt\" > ~/.ssh_clip.txt";
    vim.print(cmd);
    os.execute(cmd);
    vim.print("Pulled.");
    M.open_ssh_clip(reg);
end

function M.pull_ssh_clip_cmd(args)
    local server = args.fargs[1]
    local reg = "\""
    if #args.fargs >= 2 then
        reg = args.fargs[2]
    end
    M.pull_ssh_clip(server, reg);
end

function M.open_ssh_clip(reg)
    local file = io.open(M.clip_file, "r");
    if not file then
        vim.print("failed to open clipboard file");
        return;
    end
    local content = file:read("*a");
    file:close()

    vim.fn.setreg(reg, content, "l");
    vim.print("Loaded ssh reg file.");
end

function M.open_ssh_clip_cmd(args)
    local reg = "\""
    if #args.fargs ~= 0 then
        reg = args.fargs[1]
    end
    M.open_ssh_clip(reg);
end

function M.to_ssh_clip(reg)
    local content = vim.fn.getreg(reg);

    local file = io.open(M.clip_file, "w");
    if not file then
        vim.print("failed to open clipboard file");
        return;
    end
    file:write(content);
    file:close()
    vim.print("Wrote to ssh reg file.");
end

function M.to_ssh_clip_cmd(args)
    local reg = "\""
    if #args.fargs ~= 0 then
        reg = args.fargs[1]
    end
    M.to_ssh_clip(reg);
end

function M.setup()
    vim.api.nvim_create_user_command('OpenSshClip', M.open_ssh_clip_cmd, { nargs = '?' })
    vim.api.nvim_create_user_command('ToSshClip', M.to_ssh_clip_cmd, { nargs = '?' })
    vim.api.nvim_create_user_command('PullShhClip', M.pull_ssh_clip_cmd, { nargs = '+' })

    vim.keymap.set('n', '<leader>mm', function() M.to_ssh_clip("\"") end, { silent = true, desc = 'Save " clip to ssh clip.' })
end

return M
