local M = {}

local function config_lsp()
    -- Disable the LSP log:
    -- It gets too big too fast..
    vim.lsp.set_log_level("off")

    -- Configure NeoDev, which overrides Lua-LS LSP config for all NeoVim config files:
    require('neodev').setup()

    -- LSP Config:
    local lspconfig = require('lspconfig')

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers:
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- ClangD:
    lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = function()
            require('schilk.config.plugins.lsp.clangd_extensions').on_attach()
        end
    })

    -- Lua:
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                completion = {
                    callSnippet = "Replace"
                },
                diagnostics = {
                    disable = { "missing-fields" }
                }
            }
        }
    })

    -- Verible:
    require 'lspconfig'.verible.setup({
        capabilities = capabilities,
    })

    -- Rust-Analyzer:
    -- Note: LSP-Config is called/configured by rust-tools.nvim.
    require('schilk.config.plugins.lsp.rust_tools').config({
        capabilities = capabilities,
    })

    -- Pyright:
    require 'lspconfig'.pyright.setup({
        capabilities = capabilities,
    })

    -- Ocamllsp
    require 'lspconfig'.ocamllsp.setup({
        capabilities = capabilities,
    })

    -- texlab (Latex LSP):
    require 'lspconfig'.texlab.setup({
        capabilities = capabilities,
    })

    -- ltex (Latex Spelling):
    require 'lspconfig'.ltex.setup({
        capabilities = capabilities,
    })

    -- marksman (Markdown):
    require 'lspconfig'.marksman.setup({
        capabilities = capabilities,
    })

    -- bash-language-server (Bash/Shell sripting):
    require 'lspconfig'.bashls.setup({
        capabilities = capabilities,
    })

    -- Yaml
    require 'lspconfig'.yamlls.setup({
        capabilities = capabilities,
        settings = {
            yaml = {
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = require('schilk.config.plugins.lsp.schemas').yaml_schemas()
            }
        }
    })

    -- JSON
    require 'lspconfig'.jsonls.setup({
        capabilities = capabilities,
        settings = {
            json = {
                schemas = require('schilk.config.plugins.lsp.schemas').json_schemas(),
                validate = { enable = true },
            },
        },
    })
end


local lsp_diagnostics = true

local function toogle_lsp_diagnostics()
    if (lsp_diagnostics) then
        vim.print("Hiding LSP diagnostics..")
        vim.diagnostic.disable()
        lsp_diagnostics = false
    else
        vim.print("Showing LSP diagnostics..")
        vim.diagnostic.enable()
        lsp_diagnostics = true
    end
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
    vim.keymap.set({ 'n' }, '<leader>gH', require('trouble').toggle,
        { silent = true, desc = "LSP: Open Diagnostics Pane" })
    vim.keymap.set({ 'n' }, '<C-k>', vim.lsp.buf.hover, { silent = true, desc = "LSP: Documentation" })
    vim.keymap.set({ 'n' }, '<leader>ge', vim.diagnostic.open_float, { silent = true, desc = "LSP: Diagnostics" })

    vim.keymap.set("n", "<leader>md", toogle_lsp_diagnostics, { silent = true, desc = " 💡 Toggle LSP diagnostics." })
end

function M.config()
    config_lsp()
    config_keybinds()
end

return M
