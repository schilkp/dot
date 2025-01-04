local M = {}

function M.config()
    local key_file = io.open(os.getenv("HOME") .. "/.anthropic_api", "r")
    if not key_file then
        vim.print("No anthropic api key.")
        return
    end
    local anthropic_key = key_file:read("*a"):gsub("%s+", "")
    key_file:close()

    require('codecompanion').setup({

        strategies = {
            chat = {
                adapter = "anthropic",

                slash_commands = {
                    ["buffer"] = {
                        opts = {
                            provider = "telescope", -- default|telescope|mini_pick|fzf_lua
                        },
                    },
                    ["file"] = {
                        opts = {
                            provider = "fzf_lua", -- default|telescope|mini_pick|fzf_lua
                        },
                    },
                    ["help"] = {
                        opts = {
                            provider = "fzf_lua", -- telescope|mini_pick|fzf_lua
                        },
                    },
                    ["symbols"] = {
                        opts = {
                            provider = "fzf_lua", -- default|telescope|mini_pick|fzf_lua
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
