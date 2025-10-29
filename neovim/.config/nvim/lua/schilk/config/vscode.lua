local M = {}

local function action(s)
  return function()
    local vscode = require("vscode")
    vscode.action(s)
  end
end

function M.setup()
  if not vim.g.vscode then
    return
  end

  -- Finding/Opening:
  vim.keymap.set("n", "<leader>o", action("workbench.action.quickOpen"), { silent = true, desc = "🔍 Find File." })
  vim.keymap.set(
    "n",
    "<leader>p",
    action("workbench.action.findInFiles"),
    { silent = true, desc = "🔍 Live RipGrep." }
  )

  -- LSP:
  vim.keymap.set("v", "gf", action("editor.action.formatSelection"), { silent = true, desc = "🧹 Format." })
  vim.keymap.set("n", "<leader>F", action("editor.action.formatDocument"), { silent = true, desc = "🧹 Format." })
  vim.keymap.set("n", "<leader>gn", action("editor.action.rename"), { silent = true, desc = "LSP: Rename." })
  vim.keymap.set("n", "<leader>ga", action("editor.action.refactor"), { silent = true, desc = "LSP: Action." })
  vim.keymap.set(
    "n",
    "<leader>gd",
    action("editor.action.revealDefinition"),
    { silent = true, desc = "LSP: Goto Definition." }
  )
  vim.keymap.set(
    "n",
    "<leader>gD",
    action("editor.action.revealDeclaration"),
    { silent = true, desc = "LSP: Goto Declaration." }
  )
  vim.keymap.set(
    "n",
    "<leader>gr",
    action("editor.action.goToReferences"),
    { silent = true, desc = "LSP: Goto References." }
  )
  vim.keymap.set(
    "n",
    "<leader>gt",
    action("editor.action.goToTypeDefinition"),
    { silent = true, desc = "LSP: Goto Type Definition." }
  )
  vim.keymap.set(
    "n",
    "<leader>gh",
    action("C_Cpp.SwitchHeaderSource"),
    { silent = true, desc = "LSP: Switch Header/Source." }
  )
  vim.keymap.set("n", "<C-k>", action("editor.action.showHover"), { silent = true, desc = "LSP: Documentation" })
end

return M
