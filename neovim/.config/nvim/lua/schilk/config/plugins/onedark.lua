local M = {}

function M.config()
  require("onedark").setup({
    style = "cool",
    transparent = true,
    ending_tildes = true,
    lualine = {
      transparent = true,
    },
    highlights = {
      Comment = { fg = "#848b98" },
      SpecialComment = { fg = "#848b98" },
      TSComment = { fg = "#848b98" },
    },
    diagnostics = {
      darker = false,
      undercurl = true,
      background = false,
    },
  })
  vim.cmd.colorscheme("onedark")
end

---@type LazyPluginSpec
M.spec = {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
