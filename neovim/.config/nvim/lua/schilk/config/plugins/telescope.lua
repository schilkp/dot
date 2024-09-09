local M = {}

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
    local actions = require('telescope.actions')
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
                },
            },
        }
    }
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    vim.keymap.set('n', '<leader>fe', find_emoji, { silent = true, desc = 'Find Emoji.' })
    vim.keymap.set('n', '<leader>fg', find_gitmoji, { silent = true, desc = 'Find Gitmoji.' })
    vim.keymap.set('n', '<leader>fs', find_symbol, { silent = true, desc = 'Find Symbol.' })
    vim.keymap.set('n', '<leader>fc', find_from_compile_cmds,
        { silent = true, desc = 'Find file from compile_commands.json.' })
end

M.spec = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function() -- Only install fzf-native extension if "make" is available.
                return vim.fn.executable 'make' == 1
            end,
        },
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-symbols.nvim'
    },
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
