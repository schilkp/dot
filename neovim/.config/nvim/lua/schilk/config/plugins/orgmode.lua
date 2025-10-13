local M = {}

M.org_roam_dir = "~/org-roam"
M.org_roam_assets_dir = "~/org-roam/assets"

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
                org_edit_special = "<leader>ne"
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

--- Find + Insert image
function M.find_insert_image()
    local fzf_lua = require("fzf-lua")
    fzf_lua.files({
        cwd = M.org_roam_assets_dir,
        file_icons = false,
        actions = {
            ["default"] = function(selected)
                if selected and selected[1] then
                    vim.api.nvim_put({ "[[./assets/" .. selected[1] .. "]]", "" }, "c", true, true)
                end
            end,
        },
    })
end

local have_priv, org_templates = pcall(require, "schilk.private.org_templates")

function M.config_org_roam()

	local templates = {
		d = {
			description = "default",
			template = "%?",
			target = "%[slug].org",
		},
	}

	if have_priv then
		templates["w"] = org_templates.w
	end

	require("org-roam").setup({
		directory = M.org_roam_dir,
		bindings = {
			prefix = "<leader>n",
			add_origin = "<prefix>Oa",
			remove_origin = "<prefix>Or",
		},
		templates = templates,
	})

    vim.keymap.set("n", "<leader>nF", M.grep_notes, { silent = true, desc = "Find in notes." })
    vim.keymap.set("n", "<leader>nI", M.find_insert_image, { silent = true, desc = "Insert image." })

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
