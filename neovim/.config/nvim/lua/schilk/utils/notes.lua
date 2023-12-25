local M = {}

M.note_dir = "~/Notes/pages/"
M.journal_dir = "~/Notes/journals/"

function M.note_exists(name)
    for filename, type in vim.fs.dir(M.note_dir) do
        if type == "file" then
            local filename_normal = string.gsub(string.lower(filename), ".md", "")
            local name_normal = string.gsub(string.lower(name), ".md", "")
            if filename_normal == name_normal then
                return vim.fs.normalize(M.note_dir .. filename)
            end
        end
    end

    return nil
end

function M.note(args)
    local name = args.fargs[1]

    local note_path = M.note_exists(name)
    if note_path ~= nil then
        vim.cmd(":e " .. note_path)
    else
        local file_name = string.gsub(name, ".md", "") .. ".md"
        vim.cmd("e " .. M.note_dir .. file_name)
    end
end

function M.journal(_args)
    local journal_today = M.journal_dir .. os.date("%Y_%m_%d.md")
    vim.cmd("e " .. journal_today)
end

function M.setup()
    vim.api.nvim_create_user_command('Note', M.note, { nargs = 1 })
    vim.api.nvim_create_user_command('Journal', M.journal, { nargs = 0 })
end

return M
