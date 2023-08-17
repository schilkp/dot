local M = {}

function M.config()
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {}
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    vim.keymap.set('n', '<leader>o', require('telescope.builtin').find_files, { desc = 'Open File.' })
    local function find_in_parent()
        require('telescope.builtin').find_files({ find_command = { "rg", "--files", "--color", "never", ".." } })
    end
    vim.keymap.set('n', '<leader>O', find_in_parent, { desc = 'Open File in Parent Dir.' })
    vim.keymap.set('n', '<leader>i', require('telescope.builtin').git_files, { desc = 'Open Git File.' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').oldfiles, { desc = 'Open Recent File.' })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Open Buffer.' })
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>p', ':Rg<CR>', { desc = 'Live RipGrep.' })

    vim.keymap.set('n', '<leader>fl', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = 'Fuzzily search in current buffer' })

    local function telescope_config_files()
        require('telescope.builtin').find_files({
            search_dirs = { "~/.config/nvim/init.lua", "~/.config/nvim/lua/", "~/.vimrc" }
        })
    end
    vim.keymap.set('n', '<leader>=e', telescope_config_files, { desc = 'Open Buffer.' })

    local function telescope_notes()
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
    vim.keymap.set('n', '<leader>ww', telescope_notes, { desc = 'Open notes.' })
end

return M
