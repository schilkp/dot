local M = {}

function M.config()
    -- Load key:
    local key_file = io.open(os.getenv("HOME") .. "/.anthropic_api", "r")
    if not key_file then
        vim.print("No anthropic api key.")
        return
    end
    local anthropic_key = key_file:read("*a"):gsub("%s+", "")
    key_file:close()

    -- Pick message:
    local options = {
        { "Welcome to the ✨ AI Slop Bucket ✨! We hope you enjoy your stay.", "✨ AI Slop Bucket" },
        { "Too stupid to think for yourself again?", "✨ Brainrot" },
        { "To access all copyrighted material ever, please type below!", "✨ Imitation Station" },
    }
    local choice = options[math.random(#options)]
    local intro_msg = choice[1]
    local bind_msg = choice[2]

    -- Setup:
    require('codecompanion').setup({
        strategies = {
            chat = {
                adapter = "anthropic",
                slash_commands = {
                    ["buffer"] = {
                        opts = {
                            provider = "telescope",
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
                intro_message = intro_msg
            }
        },

        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = anthropic_key
                    },
                })
            end,
        },

    })

    vim.keymap.set({ 'n' }, '<leader>tc', ":CodeCompanionChat<CR>", { silent = true, desc = bind_msg })
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
