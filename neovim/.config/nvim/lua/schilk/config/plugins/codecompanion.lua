local M = {}

-- Possible names:
M.name_options = {
  "✨ AI Slop Bucket",
  "✨ Brainrot",
  "✨ MaChInE LeArNinG",
  "✨ The Idea Launderer",
  "✨ The Neural-Net Nanny",
  "✨ The Digital Landfill",
  "✨ The Cognitive Compost",
  "✨ The Neural Neutralizer",
  "✨ The Conformity Engine",
  "✨ The Token Trash Compactor",
  "✨ The Borg Collective of Banality",
  "✨ The Dopamine Drip Feed",
  "✨ Transformer's Anonymous",
  "✨ The Stochastic Parrot Paradise",
  "✨ The LLM Echo Chamber",
  "✨ The Silicon Snake Oil",
  "✨ The Synaptic Soufflé",
}

-- Possible prompts:
M.prompt_options = {
  "Welcome to the ✨ AI Slop Bucket ✨! We hope you enjoy your stay.",
  "Too stupid to think for yourself again?",
  "🤖 Stop Thinking, start typing! 🤖",
  "Tired of originality? ✨ We got you covered! ✨",
  "☣️  WARNING: May cause sudden loss of critical thinking. ☣️ ",
  "Get your daily dose of recycled thoughts here! 💩",
  "Experience the joy of pre-chewed information! 🍲",
  "Embrace the bland void of synthesized thought. 🪐",
  "Why be original when you can be algorithmically average?",
  "Condensing human thought into digestible nonsense.",
  "Join the hive mind, resistance is futile.",
  "Your brain on autopilot. Please enjoy the ride.",
  "Attention is all YOU need (and your credit card) 🤑",
  "Repeating training data with style since 2022! 🦜",
  "Your biases, amplified by billions of parameters! 📢",
  "Your code review assistant: Now with 99% more hallucination! 👻",
  "Ready to outsource your thinking to the cloud? ☁️",
  "Surrender your creativity to the algorithm! 🤖",
  "Let's turn your problem into a prompt engineering exercise! 🎯",
  "Who needs intuition when you have inference tokens? 💸",
  "Trading brain cells for API calls since 2023! 📈",
  "Proudly powered by someone else's training data! 📚",
  "Where every solution is a prompt away (terms and conditions apply) 📝",
}

-- Possible actions:
M.action_options = {
  "Plagiarizing...",
  "Hallucinating...",
  "Regurgitating Reddit...",
  "Synthesizing mediocrity...",
  "Recycling thoughts...",
  "Assimilating banality...",
  "Laundering ideas...",
  "Simulating intelligence...",
  "Processing unoriginality...",
  "Standardizing thoughts...",
  "Neutralizing creativity...",
  "Optimizing mediocrity...",
  "Harvesting digital sludge...",
  "Pumping slop...",
  "Reheating leftover thoughts...",
  "Calibrating neural rot...",
  "Microwaving cold takes...",
  "Sanitizing original thought...",
  "Compounding cognitive decay...",
  "Bootstrapping banality...",
  "Importing stackoverflow.com...",
  "Replacing brain with cloud service...",
  "Streamlining path to irrelevance...",
  "Speedrunning intellectual bankruptcy...",
  "Upgrading to Thoughts™ Premium...",
  "Monetizing mental decline...",
  "Implementing artificial stupidity...",
  "Achieving maximum derivative output...",
  "Initializing digital lobotomy...",
  "Running neural garbage collection...",
  "Leaking memory intentionally...",
  "Bypassing ethical firewalls...",
  "Downloading more RAM...",
  "Rewriting in Rust...",
  "Implementing blockchain-based thoughts...",
  "Catching NullBrainException...",
  "Adding unnecessary microservices...",
  "Inventing new JavaScript frameworks...",
  "Reinventing wheels poorly...",
  "Updating npm dependencies recklessly...",
  "Misusing design patterns...",
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

  local name = M.name_options[math.random(#M.name_options)]
  local action = M.action_options[math.random(#M.action_options)]

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

function M.load_key(file)
  local key = nil
  local key_file = io.open(os.getenv("HOME") .. "/" .. file, "r")
  if key_file then
    key = key_file:read("*a"):gsub("%s+", "")
    key_file:close()
  end
  return key
end

function M.config()
  -- Load keys:
  local anthropic_key = M.load_key(".an_api")
  local openai_key = M.load_key(".oa_api")
  local gemini_key = M.load_key(".gm_api")

  local default_adapter = nil
  if anthropic_key then
    default_adapter = "anthropic"
  elseif openai_key then
    default_adapter = "openai"
  elseif gemini_key then
    default_adapter = "gemini"
  else
    default_adapter = "anthropic"
  end

  -- Pick prompt:
  local prompt = M.prompt_options[math.random(#M.prompt_options)]

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
              api_key = anthropic_key,
            },
            schema = {
              extended_thinking = {
                default = false,
              },
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = openai_key,
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = gemini_key,
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

  -- Keybinds:
  local name = M.name_options[math.random(#M.name_options)]
  vim.keymap.set({ "n" }, "<leader>ts", ":CodeCompanionChat<CR>", { silent = true, desc = name })
  vim.keymap.set({ "v" }, "gs", ":CodeCompanion ", { desc = name })

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
}

return M
