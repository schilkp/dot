local M = {}

local function find_dotfiles()
    require('fzf-lua').files({ cwd = '~/dot' })
end

local function find_in_parent()
    require('fzf-lua').files({ cwd = '..' })
end

function M.config()
    require("fzf-lua").setup({

        winopts = {
            width = 0.85,
            height = 0.85,

            preview = {
                horizontal = 'right:50%',
            }
        },
        keymap = {
            fzf = {
                ["ctrl-a"] = "select-all",
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
end

M.spec = {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
