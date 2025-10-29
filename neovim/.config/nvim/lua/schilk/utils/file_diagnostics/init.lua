local M = {}

M.verilator = require("schilk.utils.file_diagnostics.verilator")

function M.cmd_reload()
  M.verilator.reload()
end

function M.cmd_clear()
  M.verilator.cmd_clear()
  vim.notify("Cleared all file diagnostics")
end

function M.setup()
  vim.api.nvim_create_user_command("FileDiagReload", M.cmd_reload, { nargs = 0 })
  vim.keymap.set({ "n" }, "<leader>tr", M.cmd_reload, { silent = true, desc = "♻️ Reload File Diags" })
  vim.keymap.set({ "n" }, "<leader>tR", M.cmd_clear, { silent = true, desc = "❌ Hide File Diags" })
  M.verilator.setup()
end

return M
