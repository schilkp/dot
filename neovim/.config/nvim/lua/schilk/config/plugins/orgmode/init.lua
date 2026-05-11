local M = {}

M.org_roam_dir = "~/org-roam"
M.org_roam_assets_dir = "~/org-roam/assets"

function M.config_org()
  -- Setup orgmode
  require("orgmode").setup({
    org_agenda_files = "~/orgfiles/**/*",
    org_default_notes_file = "~/orgfiles/refile.org",

    org_adapt_indentation = false,

    mappings = {
      prefix = "<leader>N",
      org = {
        org_open_at_point = "<leader>no",
        org_edit_special = "<leader>ne",
      },
    },
  })

  -- Enable conceal:
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    callback = function()
      vim.opt_local.conceallevel = 2
      vim.opt_local.concealcursor = "nc"
    end,
  })
end

--- Fuzzy-find in notes
function M.grep_notes()
  local fzf_lua = require("fzf-lua")
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

--- Open quickfix of all links for org-roam node under cursor
function M.open_quickfix_all_links()
  require("org-roam").ui.open_quickfix_list({
    backlinks = true,
    links = true,
    show_preview = true,
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
    -- templates["w"] = org_templates.w
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

  local to_html = require("schilk.config.plugins.orgmode.to_html").to_html
  vim.api.nvim_create_user_command("RoamToEmail", function()
    to_html()
  end, {
    desc = "Export current buffer to HTML and open in Firefox for email copy-paste",
  })

  local docupdt = require("schilk.config.plugins.orgmode.doc_updt")
  vim.api.nvim_create_user_command("RoamDocUpdtNew", function()
    docupdt.new()
  end, {
    desc = "Create a new docupdt org-roam node with the next running index.",
  })
  vim.api.nvim_create_user_command("RoamDocUpdtDone", function()
    docupdt.done()
  end, {
    desc = "Mark current docupdt org-roam node as done/remove next label.",
  })

  -- Custom org bindings (all buffers):
  vim.keymap.set("n", "<leader>nF", M.grep_notes, { silent = true, buffer = true, desc = "Find in notes." })

  -- Custom org bindings (org buffers):
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    callback = function()
      vim.keymap.set("n", "<leader>nI", M.find_insert_image, { silent = true, buffer = true, desc = "Insert image." })
      vim.keymap.set(
        "n",
        "<leader>nQ",
        M.open_quickfix_all_links,
        { silent = true, buffer = true, desc = "Open quickfix of all links for org-roam node under cursor." }
      )
    end,
    desc = "Custom org bindings.",
  })

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
  commit = "6c21c867b178a80fb4ad243c445545e5583d8232",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      commit = "1ab7b456020de8bdaed7d8135b5376a0b4419b11",
      config = M.config_org,
    },
  },
  config = M.config_org_roam,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
