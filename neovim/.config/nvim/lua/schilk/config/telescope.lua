local M = {}

local function find_in_parent()
    require('telescope.builtin').find_files({ find_command = { "rg", "--files", "--color", "never", ".." } })
end

local function find_in_buffer()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end

local function find_config_files()
    require('telescope.builtin').find_files({
        search_dirs = { "~/.config/nvim/init.lua", "~/.config/nvim/lua/", "~/.vimrc" }
    })
end

local function find_notes()
    local files = {}
    for name, type in vim.fs.dir("~/notes/") do
        if type == "file" or type == "link" then
            files[# files + 1] = vim.fs.normalize("~/notes/" .. name)
        end
    end
    -- vim.print(files)
    require('telescope.builtin').find_files({
        search_dirs = files
    })
end

local function find_emoji()
    require 'telescope.builtin'.symbols { sources = { 'emoji' } }
end

local function find_gitmoji()
    require 'telescope.builtin'.symbols { sources = { 'gitmoji' } }
end

local function find_symbol()
    require 'telescope.builtin'.symbols { sources = { 'emoji', 'gitmoji', 'julia', 'math' } }
end

local function find_from_compile_cmds()
    local f = io.open("compile_commands.json", "r")
    if f == nil then
        print("no compile_commands.json found!")
        return
    end

    local raw_content = f:read("*a")
    local content = vim.fn.json_decode(raw_content)

    local source_files = {}

    local dir_set = {}

    local include_pattern = "-I[%w/%p_-]+%s"

    for i, v in pairs(content) do
        -- Extract actual source file:
        source_files[i] = v['file']

        -- Extract source directory
        local dir = v['directory']
        if dir ~= nil then
            if dir_set[dir] == nil then
                dir_set[dir] = true
            end
        end

        -- Extract include paths:
        local cmd = v['command']
        if cmd ~= nil then
            for c in cmd:gmatch(include_pattern) do
                c = string.gsub(c, '^-I', '')
                c = string.gsub(c, '%s+$', '')
                if dir_set[c] == nil then
                    dir_set[c] = true
                end
            end
        end
    end

    local search_dirs = {}
    local n = 1

    for k, _ in pairs(dir_set) do
        k = string.gsub(k, '^-I', '')
        k = string.gsub(k, '%s+$', '')
        search_dirs[n] = k
        n = n + 1
    end

    for _, v in pairs(source_files) do
        search_dirs[n] = v
        n = n + 1
    end

    require('telescope.builtin').find_files({ search_dirs = search_dirs })
end

function M.config()
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {}
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- Key binds:
    vim.keymap.set('n', '<leader>o', require('telescope.builtin').find_files, { silent = true, desc = 'Open File.' })
    vim.keymap.set('n', '<leader>O', find_in_parent, { silent = true, desc = 'Open File in Parent Dir.' })
    vim.keymap.set('n', '<leader>i', require('telescope.builtin').git_files, { silent = true, desc = 'Open Git File.' })
    vim.keymap.set('n', '<leader>p', ':Rg<CR>', { silent = true, desc = 'Live RipGrep.' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').oldfiles, { silent = true, desc = 'Open Recent File.' })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { silent = true, desc = 'Open Buffer.' })

    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { silent = true, desc = 'Search Help Tag.' })
    vim.keymap.set('n', '<leader>fl', find_in_buffer, { silent = true, desc = 'Search in current buffer.' })
    vim.keymap.set('n', '<leader>fe', find_emoji, { silent = true, desc = 'Find Emoji.' })
    vim.keymap.set('n', '<leader>fg', find_gitmoji, { silent = true, desc = 'Find Gitmoji.' })
    vim.keymap.set('n', '<leader>fs', find_symbol, { silent = true, desc = 'Find Symbol.' })
    vim.keymap.set('n', '<leader>fc', find_from_compile_cmds, { silent = true, desc = 'Find file from compile_commands.json.' })
    vim.keymap.set('n', '<leader>fC', require('telescope.builtin').colorscheme, { silent = true, desc = 'Find colorscheme.' })
    vim.keymap.set('n', '<leader>fP', require('telescope.builtin').commands, { silent = true, desc = 'Find command.' })

    vim.keymap.set('n', '<leader>=e', find_config_files, { silent = true, desc = 'Open config file.' })
    vim.keymap.set('n', '<leader>ww', find_notes, { silent = true, desc = 'Open notes.' })
end

return M
