local M = {}

M.note_dir = "~/Notes/pages/"
M.journal_dir = "~/Notes/journals/"

-- Check if a given note file already exists in the note 
-- directory:
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

-- ':Note' command. Opens a fuzzy note finder if no argument is given.
-- If an arguemnt is given that note is opened, being created if necessary.
function M.note(args)
    if #args.fargs == 0 then
        require("schilk.config.plugins.telescope").find_notes()
        return
    end

    local name = args.fargs[1]

    local note_path = M.note_exists(name)
    if note_path ~= nil then
        vim.cmd(":e " .. note_path)
    else
        local file_name = string.gsub(name, ".md", "") .. ".md"
        vim.cmd("e " .. M.note_dir .. file_name)
    end
end

-- ':Journal' command. Opens (and creates if necessary) todays
-- journal file.
function M.journal(_args)
    local journal_today = M.journal_dir .. os.date("%Y_%m_%d.md")
    vim.cmd("e " .. journal_today)
end

function M.setup()
    vim.api.nvim_create_user_command('Note', M.note, { nargs = '?' })
    vim.api.nvim_create_user_command('Journal', M.journal, { nargs = 0 })
end

return M
