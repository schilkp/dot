local M = {}

function M.config_org()
    -- Setup orgmode
    require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',

        mappings = {
            disable_all = true,
        }
    })
end

function M.config_org_roam()
    require("org-roam").setup({
        directory = "~/org-roam",
        -- optional
        org_files = {
            "~/another_org_dir",
            "~/some/folder/*.org",
            "~/a/single/org_file.org",
        }
    })
end

M.spec = {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.1",
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
