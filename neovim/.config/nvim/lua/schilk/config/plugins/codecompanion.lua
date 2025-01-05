local M = {}


-- Pick message:
-- stylua: ignore start
---@format disable-next
M.msg_options = {
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

    local choice = M.msg_options[math.random(#M.msg_options)]
    local msg = choice[1]

    M.fidget_progress_handle = fidget.progress.handle.create({
        title = "",
        message = "Thinking..",
        lsp_client = { name = msg },
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
    -- Load key:
    local key_file = io.open(os.getenv("HOME") .. "/.anthropic_api", "r")
    if not key_file then
        vim.notify("🤖 No anthropic api key. CodeCompanion not active.", vim.log.levels.WARN)
        return
    end
    local anthropic_key = key_file:read("*a"):gsub("%s+", "")
    key_file:close()

    -- Pick message:
    local choice = M.msg_options[math.random(#M.msg_options)]
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
