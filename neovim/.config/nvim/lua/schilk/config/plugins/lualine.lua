local M = {}

function M.config()
  local have_copilot, _ = pcall(require, "copilot")
  local lualine_x = { "encoding", "fileformat", "filetype" }
  if have_copilot then
    local copilot = {
      "copilot",
      -- Default values
      symbols = {
        status = {
          icons = {
            disabled = "",
            unknown = "",
          },
        },
      },
    }
    table.insert(lualine_x, 1, copilot)
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", { "diagnostics", colored = false } },
      lualine_c = { "filename" },
      lualine_x = lualine_x,
      lualine_y = { "progress", file_prog }, -- TODO? Undefined?
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
end

---@type LazyPluginSpec
M.spec = {
  "nvim-lualine/lualine.nvim",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

return M
