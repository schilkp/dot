local M = {}

function M.config()
  local actions = require("fzf-lua.actions")
  require("fzf-lua").setup({

    winopts = {
      width = 0.85,
      height = 0.85,

      preview = {
        horizontal = "right:50%",
      },
    },
    keymap = {
      fzf = {
        ["ctrl-a"] = "select-all",
      },
    },
    files = {
      git_icons = true,
      hidden = true,
      follow = true,
      no_ignore = false,
      actions = {
        ["ctrl-g"] = { actions.toggle_ignore },
      },
    },
  })

  require("fzf-lua").register_ui_select()
end

---@type LazyKeys[]
M.keybinds = {
  {
    "<leader>o",
    function()
      require("fzf-lua").files()
    end,
    desc = "🔍 Find File.",
  },
  {
    "<leader>O",
    function()
      require("fzf-lua").files({ cwd = ".." })
    end,
    desc = "🔍 Find File in Parent Dir.",
  },
  {
    "<leader>i",
    function()
      require("fzf-lua").git_files()
    end,
    desc = "🔍 Open Git File.",
  },
  {
    "<leader>p",
    function()
      require("fzf-lua").live_grep_native()
    end,
    desc = "🔍 Live RipGrep.",
  },
  {
    "<leader>fd",
    function()
      require("fzf-lua").files({ cwd = "~/dot" })
    end,
    desc = "Open Dotfiles.",
  },
  {
    "<leader>fD",
    function()
      require("fzf-lua").files({ cwd = "~/dot_priv" })
    end,
    desc = "Open Private Dotfiles.",
  },
  {
    "<leader>fb",
    function()
      require("fzf-lua").buffers()
    end,
    desc = "Open Buffer.",
  },
  {
    "<leader>fh",
    function()
      require("fzf-lua").help_tags()
    end,
    desc = "Search Help Tag.",
  },
  {
    "<leader>fr",
    function()
      require("fzf-lua").oldfiles()
    end,
    desc = "Open Recent File.",
  },
  {
    "<leader>fl",
    function()
      require("fzf-lua").blines()
    end,
    desc = "Search in current buffer.",
  },
  {
    "<leader>fC",
    function()
      require("fzf-lua").colorschemes()
    end,
    desc = "Find colorscheme.",
  },
  {
    "<leader>fP",
    function()
      require("fzf-lua").commands()
    end,
    desc = "Find command.",
  },
}

---@type LazyPluginSpec
M.spec = {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
  -- Lazy load:
  cmd = "FzfLua",
  keys = M.keybinds,
}

return M
