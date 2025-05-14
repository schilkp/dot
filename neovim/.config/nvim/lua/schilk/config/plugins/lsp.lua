local M = {}

local function config_lsp()
    -- Disable the LSP log:
    -- It gets too big too fast..
    vim.lsp.set_log_level("ERROR")

    -- ---===--- MASON ---===---

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = {
            "bashls",
            "lua_ls",
        }
    }

    -- ---===--- LSP CONFIG ---===---

    -- LSP Config:
    local lspconfig = require('lspconfig')

    -- Blink CMP capabilities:
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local has_blink, _ = pcall(require, "blink.cmp")
    if has_blink then
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    end

    -- Inject manually configured local lsps:
    _G.SCHILK_LOCAL_LSPS_CB = _G.SCHILK_LOCAL_LSPS_CB or function(_, on_attach) on_attach() end
    _G.SCHILK_LOCAL_LSPS_CB(capabilities, function() end)

    -- Allow skipping of default LSPs:
    ---@type string[]
    _G.SCHILK_SKIP_LSPS = _G.SCHILK_SKIP_LSPS or {}
    local skip_lsp = _G.SCHILK_SKIP_LSPS

    local lsps = {
        verible = {},
        clangd = {},
        basedpyright = {},
        gopls = {},
        ocamllsp = {},
        texlab = {},
        -- ltext = {},
        marksman = {},
        bashls = {},
        tailwindcss = {},
        emmet_language_server = {},
        zls = {},
        neocmake = {},
        tinymist = {},
        ts_ls = {
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
            },
        },
        yamlls = {
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require('schilk.config.plugins.lsp.schemas').yaml_schemas()
                }
            }
        },
        jsonls = {
            settings = {
                json = {
                    schemas = require('schilk.config.plugins.lsp.schemas').json_schemas(),
                    validate = { enable = true },
                },
            },
        }
    }

    -- Inject standard local lsps:
    _G.SCHILK_LOCAL_LSPS = _G.SCHILK_LOCAL_LSPS or {}
    lsps = vim.tbl_extend("force", lsps, _G.SCHILK_LOCAL_LSPS)

    for lsp, config in pairs(lsps) do
        if skip_lsp[lsp] == nil or not skip_lsp[lsp] then
            lspconfig[lsp].setup({
                capabilities = capabilities,
                settings = config.settings,
                filetypes = config.filetypes,
            })
        end
    end

    -- Rust-Analyzer:
    -- Note: LSP-Config is called/configured by rust-tools.nvim.
    require('schilk.config.plugins.lsp.rust_tools').config({
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                procMacro = {
                    enable = true
                },
            }
        }
    })
end


local function toggle_buffer_lsp_diagnostics()
    local enabled = vim.diagnostic.is_enabled({ bufnr = 0 });

    if enabled then
        vim.print("Hiding Buffer LSP diagnostics..")
        vim.diagnostic.enable(false, { bufnr = 0 })
    else
        vim.print("Showing Buffer LSP diagnostics..")
        vim.diagnostic.enable(true, { bufnr = 0 })
    end
end

local all_lsp_diagnostic_hidden = false;
local function toggle_lsp_diagnostics()
    if (all_lsp_diagnostic_hidden) then
        vim.print("Showing LSP diagnostics..")
        all_lsp_diagnostic_hidden = false
    else
        vim.print("Hiding LSP diagnostics..")
        all_lsp_diagnostic_hidden = true
    end

    for _, v in ipairs(vim.fn.getwininfo()) do
        if (all_lsp_diagnostic_hidden) then
            vim.diagnostic.enable(false, { bufnr = v.bufnr })
        else
            vim.diagnostic.enable(true, { bufnr = v.bufnr })
        end
    end
end

local function toggle_buffer_semantic_highlight()
    local hidden = vim.b.schilk_semantic_highlight_hidden or false
    local bufnr = vim.fn.bufnr()

    if (hidden) then
        vim.print("Showing Buffer LSP semantic highlight..")
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            vim.lsp.semantic_tokens.start(bufnr, client.id)
        end
        vim.b.schilk_semantic_highlight_hidden = false
    else
        vim.print("Hiding Buffer LSP semantic highlight..")
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            vim.lsp.semantic_tokens.stop(bufnr, client.id)
        end
        vim.b.schilk_semantic_highlight_hidden = true
    end
end

local all_semantic_highlight_hidden = false;
local function toggle_semantic_highlight()
    if (all_semantic_highlight_hidden) then
        vim.print("Showing Semantic Highlight..")
        all_semantic_highlight_hidden = false
    else
        vim.print("Hiding Semantic Highlight..")
        all_semantic_highlight_hidden = true
    end

    for _, v in ipairs(vim.fn.getwininfo()) do
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = v.bufnr })) do
            if (all_semantic_highlight_hidden) then
                vim.print("bufnr " .. v.bufnr .. " client " .. client.name .. " OFF")
                vim.lsp.semantic_tokens.stop(v.bufnr, client.id)
            else
                vim.print("bufnr " .. v.bufnr .. " client " .. client.name .. " ON")
                vim.lsp.semantic_tokens.start(v.bufnr, client.id)
            end
        end

        vim.b[v.bufnr].schilk_semantic_highlight_hidden = all_semantic_highlight_hidden
    end
end


local next_style_map = {
    underline = "virtual_lines",
    virtual_lines = "virtual_text",
    virtual_text = "underline"
}

local all_diagnostics_style = "virtual_text";
local function cycle_diagnostics_style()
    local new_style = next_style_map[all_diagnostics_style]

    vim.print("Setting diagnostics style to " .. new_style .. "!")
    vim.diagnostic.config({
        virtual_lines = (new_style == "virtual_lines"),
        underline = (new_style == "underline"),
        virtual_text = (new_style == "virtual_text")
    })
    all_diagnostics_style = new_style
end

local function config_keybinds()
    -- LSP Navigation Binds:
    vim.keymap.set({ 'n' }, '<leader>gd', vim.lsp.buf.definition, { silent = true, desc = "LSP: Goto Definition." })      -- TODO make saga?
    vim.keymap.set({ 'n' }, '<leader>gD', vim.lsp.buf.declaration, { silent = true, desc = "LSP: Goto Declaration." })
    vim.keymap.set({ 'n' }, '<leader>gr', vim.lsp.buf.references, { silent = true, desc = "LSP: Goto References." })      -- TODO mage saga?
    vim.keymap.set({ 'n' }, '<leader>gI', vim.lsp.buf.implementation,
        { silent = true, desc = "LSP: Goto Implementation." })                                                            -- TODO make telescope?
    vim.keymap.set({ 'n' }, '<leader>gi', vim.lsp.buf.incoming_calls,
        { silent = true, desc = "LSP: Goto Incoming Calls." })                                                            -- TODO make SAGA?
    vim.keymap.set({ 'n' }, '<leader>gt', vim.lsp.buf.type_definition, { silent = true, desc = "LSP: Type Definition." }) -- TODO make SAGA?
    vim.keymap.set({ 'n' }, '<leader>go', vim.lsp.buf.outgoing_calls,
        { silent = true, desc = "LSP: Goto Outgoing Calls." })                                                            -- TODO make SAGA?
    vim.keymap.set({ 'n' }, '<leader>gh', ':ClangdSwitchSourceHeader<CR>',
        { silent = true, desc = "LSP: Switch Header/Source." })

    -- LSP Action Binds:
    vim.keymap.set({ 'n' }, '<leader>gn', vim.lsp.buf.rename, { silent = true, desc = "LSP: Rename." })
    vim.keymap.set({ 'n' }, '<leader>ga', vim.lsp.buf.code_action, { silent = true, desc = "LSP: Code Actions" })

    -- Diagnostics:
    vim.keymap.set({ 'n' }, '<C-k>', vim.lsp.buf.hover, { silent = true, desc = "LSP: Documentation" })
    vim.keymap.set({ 'n' }, '<leader>ge', vim.diagnostic.open_float, { silent = true, desc = "LSP: Diagnostics" })

    vim.keymap.set("n", "<leader>md", toggle_buffer_lsp_diagnostics,
        { silent = true, desc = "💡 Toggle LSP diagnostics for current buffer." })
    vim.keymap.set("n", "<leader>mD", toggle_lsp_diagnostics,
        { silent = true, desc = "💡 Toggle LSP diagnostics for all buffers." })
    vim.keymap.set("n", "<leader>ms", toggle_buffer_semantic_highlight,
        { silent = true, desc = "💡 Toggle LSP semantic highlight for current buffer." })
    vim.keymap.set("n", "<leader>mS", toggle_semantic_highlight,
        { silent = true, desc = "💡 Toggle LSP semantic highlight for all buffers." })
    vim.keymap.set("n", "<leader>me", cycle_diagnostics_style,
        { silent = true, desc = "💡 Toggle LSP diagnostics for current buffer." })
end

function M.config()
    config_lsp()
    config_keybinds()
    vim.diagnostic.config({
        virtual_lines = (all_diagnostics_style == "virtual_lines"),
        underline = (all_diagnostics_style == "underline"),
        virtual_text = (all_diagnostics_style == "virtual_text")
    })
end

function M.fidget_config()
    require("fidget").setup({
        notification = {
            override_vim_notify = true,
            view = {
                stack_upwards = false,
            },
            window = {
                winblend = 0
            }
        }
    });
end

---@type LazyPluginSpec
M.spec = {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'j-hui/fidget.nvim',
            config = M.fidget_config,
            priority = 100,
        },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
            dependencies = {
                { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
            }
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- rust:
        'simrat39/rust-tools.nvim',
        -- json/yaml schemas:
        'b0o/schemastore.nvim',
    },
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
