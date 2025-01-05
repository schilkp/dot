local M = {}

function M.config()
    -- Load key:
    local key_file = io.open(os.getenv("HOME") .. "/.anthropic_api", "r")
    if not key_file then
        vim.notify("🤖 No anthropic api key. CodeCompanion not active.", vim.log.levels.WARN)
        return
    end
    local anthropic_key = key_file:read("*a"):gsub("%s+", "")
    key_file:close()

    -- Pick message:

    -- stylua: ignore start
    ---@format disable-next
    local options = {
        { "✨ AI Slop Bucket",                  "Welcome to the ✨ AI Slop Bucket ✨! We hope you enjoy your stay." },
        { "✨ Brainrot",                        "Too stupid to think for yourself again?" },
        { "✨ MaChInE LeArNinG",                "🤖 Stop Thinking, start typing! 🤖" },
        { "✨ The Idea Launderer",              "Tired of originality? ✨ We got you covered! ✨" },
        { "✨ The Neural-Net Nanny",            "☣️  WARNING: May cause sudden loss of critical thinking. ☣️ " },
        { "✨ The Digital Landfill",            "Get your daily dose of recycled thoughts here! 💩" },
        { "✨ The Cognitive Compost",           "Experience the joy of pre-chewed information!" },
        { "✨ The Neural Neutralizer",          "Embrace the bland void of synthesized thought." },
        { "✨ The Conformity Engine",           "Why be original when you can be algorithmically average?" },
        { "✨ The Borg Collective of Banality", "Join the hive mind, resistance is futile." },
        { "✨ The Dopamine Drip Feed",          "Your brain on autopilot. Please enjoy the ride." },
    }
    -- stylua: ignore end

    local choice = options[math.random(#options)]
    local bind_msg = choice[1]
    local intro_msg = choice[2]

    -- Setup:
    require("codecompanion").setup({
        strategies = {
            chat = {
                adapter = "anthropic",
                slash_commands = {
                    ["buffer"] = {
                        opts = {
                            provider = "fzf_lua",
                        },
                    },
                    ["file"] = {
                        opts = {
                            provider = "fzf_lua",
                        },
                    },
                    ["help"] = {
                        opts = {
                            provider = "fzf_lua",
                        },
                    },
                    ["symbols"] = {
                        opts = {
                            provider = "fzf_lua",
                        },
                    },
                },
            },
            inline = {
                adapter = "anthropic",
            },
            cmd = {
                adapter = "anthropic",
            },
        },

        display = {
            chat = {
                intro_message = intro_msg,
            },
        },

        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = anthropic_key,
                    },
                })
            end,
        },
    })

    vim.keymap.set({ "n" }, "<leader>ts", ":CodeCompanionChat<CR>", { silent = true, desc = bind_msg })
    vim.keymap.set({ "v" }, "gs", ":CodeCompanion ", { desc = bind_msg })
end

M.spec = {

    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
