local M = {}

function M.config()
  require("typst-preview").setup({
    dependencies_bin = {
      ["tinymist"] = "tinymist", -- Use system tinymist
    },
  })
  vim.keymap.set({ "n" }, "<leader>ll", ":TypstPreviewToggle<cr>", { silent = true, desc = "Typst: Preview Toggle." })
  vim.keymap.set(
    { "n" },
    "<leader>lf",
    ":TypstPreviewFollowCursorToggle<cr>",
    { silent = true, desc = "Typst: Follow Cursor Toggle." }
  )
  vim.keymap.set({ "n" }, "<leader>lv", ":TypstPreviewSyncCursor<cr>", { silent = true, desc = "Typst: Sync Cursor." })

  -- Function to set port:
  vim.api.nvim_create_user_command("TypstPreviewSetPort", function(opts)
    local port
    if #opts.fargs == 0 then
      -- Default to random port:
      port = 0
    else
      port = tonumber(opts.fargs[1])
      if not port then
        vim.notify("Invalid port number", vim.log.levels.ERROR)
        return
      end
    end
    require("typst-preview.config").opts.port = port

    local port_str = tostring(port)
    if port == 0 then
      port_str = "random"
    end
    vim.notify("Typst preview port set to " .. port_str .. " (will apply to next server started)", vim.log.levels.INFO)
  end, {
    nargs = "?",
    desc = "Set the port for the next typst preview server",
  })
end

---@type LazyPluginSpec
M.spec = {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
