local M = {}

local ALL_KINDS = vim.tbl_filter(function(k)
  return type(k) == "string"
end, vim.tbl_keys(vim.lsp.protocol.SymbolKind))

function M.config()
  require("aerial").setup({
    backends = {
      ["_"] = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
      verilog = { "treesitter" },
      systemverilog = { "treesitter" },
    },
    layout = {
      min_width = 15,
    },
    filter_kind = {
      ["_"] = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },
      verilog = ALL_KINDS,
      systemverilog = ALL_KINDS,
    },
  })
  vim.keymap.set({ "n" }, "<leader>mo", "<cmd>AerialToggle!<CR>", { silent = true, desc = "📋 Toggle Outline." }) -- TODO make saga?
end

---@type LazyPluginSpec
M.spec = {
  "schilkp/aerial.nvim",
  config = M.config,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
