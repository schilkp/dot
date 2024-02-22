local M = {}

local function find_dotfiles()
    require('fzf-lua').files({ cwd = '~/dotfiles' })
end

local function find_in_parent()
    require('fzf-lua').files({ cwd = '..' })
end

function M.find_notes()
    local fzf_lua = require 'fzf-lua'

    local files = {}
    for name, type in vim.fs.dir(require("schilk.utils.notes").note_dir) do
        if type == "file" or type == "link" then
            files[# files + 1] = name
        end
    end

    local opts = {}
    opts.fn_transform = function(x)
        return fzf_lua.utils.ansi_codes.magenta(x)
    end
    opts.actions = {
        ['default'] = function(selected)
            local full_path = vim.fs.normalize(require("schilk.utils.notes").note_dir .. selected[1])
            vim.cmd("e " .. full_path)
        end
    }
    opts.preview = "bat --style=plain --color=always " ..
    vim.fs.normalize(require("schilk.utils.notes").note_dir) .. "/{}"

    fzf_lua.fzf_exec(files, opts)
end

function M.config()
    require("fzf-lua").setup({
        winopts = {
            width = 0.85,
            height = 0.85,

            preview = {
                horizontal = 'right:50%',
            }
        }
    })

    -- Global maps:
    vim.keymap.set('n', '<leader>o', require('fzf-lua').files, { silent = true, desc = '🔍 Find File.' })
    vim.keymap.set('n', '<leader>O', find_in_parent, { silent = true, desc = '🔍 Find File in Parent Dir.' })
    vim.keymap.set('n', '<leader>i', require('fzf-lua').git_files, { silent = true, desc = '🔍 Open Git File.' })
    vim.keymap.set('n', '<leader>p', require('fzf-lua').live_grep_native, { silent = true, desc = '🔍 Live RipGrep.' })

    -- leader-f Find maps:
    vim.keymap.set('n', '<leader>fd', find_dotfiles, { silent = true, desc = 'Open Dotfiles.' })
    vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { silent = true, desc = 'Open Buffer.' })
    vim.keymap.set('n', '<leader>fh', require('fzf-lua').help_tags, { silent = true, desc = 'Search Help Tag.' })
    vim.keymap.set('n', '<leader>fr', require('fzf-lua').oldfiles, { silent = true, desc = 'Open Recent File.' })
    vim.keymap.set('n', '<leader>fl', require('fzf-lua').blines, { silent = true, desc = 'Search in current buffer.' })
    vim.keymap.set('n', '<leader>fC', require('fzf-lua').colorschemes, { silent = true, desc = 'Find colorscheme.' })
    vim.keymap.set('n', '<leader>fP', require('fzf-lua').commands, { silent = true, desc = 'Find command.' })

    vim.keymap.set('n', '<leader>fn', M.find_notes, { silent = true, desc = 'Open notes.' })
end

return M
