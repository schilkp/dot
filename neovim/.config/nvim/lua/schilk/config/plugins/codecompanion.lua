local M = {}

local flavour = require("schilk.config.plugins.codecompanion_flavour")

---@type LazyKeys[]
M.keybinds = {
  { "<leader>ts", ":CodeCompanionChat<CR>", mode = "n", desc = "✨ AI Chat", silent = true },
  { "gs", ":CodeCompanion ", mode = "v", desc = "✨ AI Prompt" },
}

function M.start_req_fidget()
  local has_fidget, fidget = pcall(require, "fidget")
  if not has_fidget then
    return
  end

  if M.fidget_progress_handle then
    M.fidget_progress_handle.message = "Abort."
    M.fidget_progress_handle:cancel()
    M.fidget_progress_handle = nil
  end

  local name = flavour.name_options[math.random(#flavour.name_options)]
  local action = flavour.action_options[math.random(#flavour.action_options)]

  M.fidget_progress_handle = fidget.progress.handle.create({
    title = "",
    message = action,
    lsp_client = { name = name },
    -- percentage = 0
  })
end

function M.stop_req_fidget()
  local has_fidget, _ = pcall(require, "fidget")
  if not has_fidget then
    return
  end

  if M.fidget_progress_handle then
    M.fidget_progress_handle.message = "Done."
    M.fidget_progress_handle:finish()
    M.fidget_progress_handle = nil
  end
end

function M.config()
  local priv = require("schilk.private.codecompanion_models")
  local default_adapter = priv.setup()

  -- Pick prompt:
  local prompt = flavour.prompt_options[math.random(#flavour.prompt_options)]

  -- Setup:
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = default_adapter,
        slash_commands = {
          ["buffer"] = { opts = { provider = "fzf_lua" } },
          ["file"] = { opts = { provider = "fzf_lua" } },
          ["help"] = { opts = { provider = "fzf_lua" } },
          ["symbols"] = { opts = { provider = "fzf_lua" } },
        },
        keymaps = {
          next_chat = {
            modes = {
              n = "<C-S-F12>", -- can't disabled !#@! Move out of the way..
            },
          },
          previous_chat = {
            modes = {
              n = "<C-S-F11>", -- can't disabled !#@! Move out of the way..
            },
          },
        },
      },
      inline = { adapter = default_adapter },
      cmd = { adapter = default_adapter },
    },

    display = {
      chat = {
        intro_message = prompt,
      },
    },

    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = priv.anthropic_key,
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = priv.openai_key,
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = priv.gemini_key,
            },
          })
        end,
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer
          keymap = "gh",
          -- Automatically generate titles for new chats
          auto_generate_title = true,
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = true,
          -- Picker interface ("telescope", "snacks" or "default")
          picker = "telescope",
          ---Enable detailed logging for history extension
          enable_logging = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          -- Save all chats by default
          auto_save = true,
          -- Keymap to save the current chat manually
          save_chat_keymap = "sc",
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 0,
        },
      },
    },

    ignore_warnings = true,
  })

  -- Fidget integration:
  local has_fidget, _ = pcall(require, "fidget")
  if has_fidget then
    -- New AU group:
    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    -- Attach:
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          M.start_req_fidget()
        elseif request.match == "CodeCompanionRequestFinished" then
          M.stop_req_fidget()
        end
      end,
    })
  end
end

---@type LazyPluginSpec
M.spec = {

  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/codecompanion-history.nvim",
    },
  },

  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim

  priority = 2,

  -- Lazy load:
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCmd",
    "CodeCompanionToggle",
    "CodeCompanionActions",
  },
  keys = M.keybinds,
}

return M
