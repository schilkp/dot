local M = {}

M.org_roam_dir = "~/org-roam"

function M.config_org()
    -- Setup orgmode
    require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',

        org_adapt_indentation = false,

        mappings = {
            prefix = "<leader>N",
            org = {
                org_open_at_point = "<leader>no",
            }
        }
    })

    -- Enable conceal:
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "org",
        callback = function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.concealcursor = 'nc'
        end,
    })
end

--- Fuzzy-find in notes
function M.grep_notes()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.live_grep_native({ cwd = M.org_roam_dir })
end

function M.config_org_roam()
    require("org-roam").setup({
        directory = M.org_roam_dir,
        bindings = {
            prefix = "<leader>n",
            add_origin = "<prefix>Oa",
            remove_origin = "<prefix>Or",
        },
        templates = {
            d = {
                description = "default",
                template = "%?",
                target = "%[slug].org",
            },
        }

    })

    vim.keymap.set('n', '<leader>nF', M.grep_notes, { silent = true, desc = 'Find in notes.' })

    -- Disable blink completion in select buffer:
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "org-roam-select",
        callback = function()
            vim.b.completion = false
        end,
        desc = "Disable completion in org-roam-select buffers",
    })
end

---@type LazyPluginSpec
M.spec = {
    "chipsenkbeil/org-roam.nvim",
    dependencies = {
        {
            "nvim-orgmode/orgmode",
            config = M.config_org
        },
    },
    config = M.config_org_roam,
    cond = not vim.g.vscode -- Disable in vscode-neovim
}

return M
