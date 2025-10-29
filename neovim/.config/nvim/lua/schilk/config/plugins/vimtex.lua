local M = {}

function M.config()
  vim.cmd("let g:vimtex_mappings_enabled = 1")
  vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
  vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'")
  vim.cmd("let g:vimtex_quickfix_open_on_warning = 0")
  vim.cmd('let maplocalleader = " "')
end

---@type LazyPluginSpec
M.spec = {
  "lervag/vimtex",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
