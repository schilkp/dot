local M = {}

function M.config()
  require("dirbuf").setup({})
  vim.keymap.set({ "n" }, "-", "", { silent = true }) -- Remove default mapping.
  vim.keymap.set(
    { "n" },
    "<leader>Q",
    "<Plug>(dirbuf_up)",
    { silent = true, noremap = false, desc = "🌳 Open DirBuf." }
  )
end

---@type LazyPluginSpec
M.spec = {
  "elihunter173/dirbuf.nvim",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
