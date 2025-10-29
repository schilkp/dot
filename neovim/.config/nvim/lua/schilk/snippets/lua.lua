local M = {}
local ls = require("luasnip")

-- stylua: ignore start
M.snippets = {
  ls.parser.parse_snippet({ trig = "module" }, [[
  local M = {}

  return M
  ]]),

  ls.parser.parse_snippet({ trig = "module_config" }, [[
  local M = {}

  function M.config()
    -- Call plugin setup:

    -- Other config:

  end

  ---@type LazyPluginSpec
  M.spec = {
    '',
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
  }

  return M
  ]]),

  ls.parser.parse_snippet({ trig = "schilk.nvim.lua" }, [[
    local utils = require('schilk.utils.project_config_utils');
    local local_config_file = utils.get_local_config_path(debug.getinfo(1).source)
    local local_config_dir = utils.get_local_config_dir(local_config_file)
    
    -- Startup note/message
    ---@type string[]|nil
    _G.SCHILK_LOCAL_NOTE = nil

    -- Extra plugins to be inserted into the lazy spec
    ---@type LazySpec[]
    _G.SCHILK_LOCAL_PLUGINS = {
    }

    -- Skip config LSPs
    _G.SCHILK_SKIP_LSPS = {
      -- ts_ls: true
    }

    -- Additional LSPs
    _G.SCHILK_LOCAL_LSPS = {
    }

    _G.SCHILK_LOCAL_LSPS_CB = function(capabilities, on_attach)
      local lspconfig = require "lspconfig";
    end
    
  ]]),

  ls.parser.parse_snippet({ trig = "schilk.nvim.lua_plugin" }, [[
    ---@type LazyPluginSpec
    {
      '',
      dependencies = {
      },
      config = function()
      end,
      cond = not vim.g.vscode, -- Disable in vscode-neovim
    }$0
  ]]),

  ls.parser.parse_snippet({ trig = "schilk.nvim.lua_lsp" }, [[
    local $1_lsp_path = vim.fs.joinpath(local_config_dir, "");
    if vim.uv.fs_stat($1_lsp_path) then
      lspconfig.$2.setup({
        capabilities = capabilities,
        on_attach = function()
          vim.notify("Using local $1 lsp (" .. $1_lsp_path .. ")", vim.log.levels.INFO)
          on_attach()
        end,
        cmd = { $1_lsp_path }
      })
    end
  ]]),
}
-- stylua: ignore end

return M
