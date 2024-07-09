local M       = {}

M.note_dir    = "~/notes/pages/"
M.journal_dir = "~/notes/journals/"

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
        M.find_notes()
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
function M.journal(_)
    local journal_today = M.journal_dir .. os.date("%Y_%m_%d.md")
    vim.cmd("e " .. journal_today)
end

-- Fuzzy-find note
function M.find_notes()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.files({ cwd = M.note_dir })
end

-- Fuzzy-find in notes
function M.grep_notes()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.live_grep_native({ cwd = M.note_dir })
end

-- Fuzzy-find journal
function M.find_journal()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.files({ cwd = M.journal_dir })
end

-- Fuzzy-find in journals
function M.grep_journal()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.live_grep_native({ cwd = M.journal_dir })
end

function M.logseq_hi()
    -- Override header rules to allow '-' at start
    vim.cmd("syn region markdownH1 matchgroup=markdownH1Delimiter start=\"[- ]*#\\s\"      end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")
    vim.cmd("syn region markdownH2 matchgroup=markdownH2Delimiter start=\"[- ]*##\\s\"     end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")
    vim.cmd("syn region markdownH3 matchgroup=markdownH3Delimiter start=\"[- ]*###\\s\"    end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")
    vim.cmd("syn region markdownH4 matchgroup=markdownH4Delimiter start=\"[- ]*####\\s\"   end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")
    vim.cmd("syn region markdownH5 matchgroup=markdownH5Delimiter start=\"[- ]*#####\\s\"  end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")
    vim.cmd("syn region markdownH6 matchgroup=markdownH6Delimiter start=\"[- ]*######\\s\" end=\"#*\\s*$\" keepend oneline contains=@markdownInline,markdownAutomaticLink contained")

    -- Disable code blocks:
    vim.cmd("syn clear markdownCodeBlock")
end

function M.setup()
    vim.api.nvim_create_user_command('Note', M.note, { nargs = '?' })
    vim.api.nvim_create_user_command('Journal', M.journal, { nargs = 0 })
    vim.api.nvim_create_user_command('LogseqHighlight', M.logseq_hi, { nargs = 0 })

    vim.keymap.set('n', '<leader>fn', M.find_notes, { silent = true, desc = 'Open note.' })
    vim.keymap.set('n', '<leader>fN', M.grep_notes, { silent = true, desc = 'Find in notes.' })
    vim.keymap.set('n', '<leader>fj', M.find_journal, { silent = true, desc = 'Open journal.' })
    vim.keymap.set('n', '<leader>fJ', M.grep_journal, { silent = true, desc = 'Find in journals.' })
end

return M
