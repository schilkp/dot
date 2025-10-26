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

--- Export + Open as HTML (for copy-paste to email)
function M.to_html()
	-- absolute path:
	local current_file = vim.fn.expand("%:p")

	-- Sanity/error checks:
	if current_file == "" then
		vim.notify("No file in current buffer", vim.log.levels.ERROR)
		return
	end
	if vim.fn.executable("pandoc") == 0 then
		vim.notify("pandoc is not available in PATH", vim.log.levels.ERROR)
		return
	end
	if vim.fn.executable("firefox") == 0 then
		vim.notify("firefox is not available in PATH", vim.log.levels.ERROR)
		return
	end

	-- Run pandoc
	local pandoc_cmd = {
		"pandoc",
		"--embed-resources",
		"--standalone",
		"--mathml",
		"--variable",
		"maxwidth=60em",
		current_file,
		"-o",
		"/tmp/roam.html",
	}
	local pandoc_result = vim.system(pandoc_cmd, { cwd = vim.fn.expand(M.org_roam_dir) }):wait()
	if pandoc_result.code ~= 0 then
		vim.notify("Pandoc conversion failed: " .. (pandoc_result.stderr or ""), vim.log.levels.ERROR)
		return
	end

	-- Open in firefox
	vim.system({ "firefox", "/tmp/roam.html" })
	vim.notify("Opening HTML..", vim.log.levels.INFO)
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

    vim.api.nvim_create_user_command('RoamToEmail', function()
		M.to_html()
    end, {
        desc = 'Export current buffer to HTML and open in Firefox for email copy-paste'
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
