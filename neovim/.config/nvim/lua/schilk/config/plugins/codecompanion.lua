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
    { "✨ The Cognitive Compost",           "Experience the joy of pre-chewed information! 🍲" },
    { "✨ The Neural Neutralizer",          "Embrace the bland void of synthesized thought. 🪐" },
    { "✨ The Conformity Engine",           "Why be original when you can be algorithmically average?" },
    { "✨ The Token Trash Compactor",       "Condensing human thought into digestible nonsense." },
    { "✨ The Borg Collective of Banality", "Join the hive mind, resistance is futile." },
    { "✨ The Dopamine Drip Feed",          "Your brain on autopilot. Please enjoy the ride." },
    { "✨ Transformer's Anonymous",         "Attention is all YOU need (and your credit card) 🤑" },
    { "✨ The Stochastic Parrot Paradise",  "Repeating training data with style since 2022! 🦜" },
    { "✨ The LLM Echo Chamber",            "Your biases, amplified by billions of parameters! 📢" }
}

M.actions = {
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

    local name = M.msg_options[math.random(#M.msg_options)][1]
    local action = M.actions[math.random(#M.actions)]

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
    local anthropic_key = M.load_key(".anthropic_api")
    local openai_key = M.load_key(".openai_api")
    local gemini_key = M.load_key(".gemini_api")

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
                    ["buffer"] = { opts = { provider = "fzf_lua", }, },
                    ["file"] = { opts = { provider = "fzf_lua", }, },
                    ["help"] = { opts = { provider = "fzf_lua", }, },
                    ["symbols"] = { opts = { provider = "fzf_lua", }, },
                },
            },
            inline = { adapter = "anthropic", },
            cmd = { adapter = "anthropic", },
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
