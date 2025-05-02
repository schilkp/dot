local M = {}

function M.config()
    -- LuaSnip
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    -- Base table of options

    ---@type blink.cmp.Config
    local opts = {
        keymap = {

            -- Available commands:
            --   show, hide, cancel, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
            --   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-g>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },

            ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },

            -- ['<C-p>'] = { 'select_prev', 'fallback' },
            -- ['<C-n>'] = { 'select_next', 'fallback' },

            ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = function(ctx)
                        return vim.bo[ctx.bufnr].filetype ~= "codecompanion"
                    end,
                }
            },

            trigger = {
                show_on_keyword = false,
                show_on_trigger_character = false,
            },

            documentation = {
                auto_show = true,
            },

            ghost_text = {
                enabled = false,
            },

            menu = {
                auto_show = true,
            }
        },

        snippets = { preset = 'luasnip' },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {}
        },

        signature = { enabled = true }, -- experimental

        cmdline = {
            enabled = false,
        }

    }


    local has_orgmode, _ = pcall(require, "orgmode")
    if has_orgmode then
        ---@diagnostic disable-next-line: param-type-mismatch
        table.insert(opts.sources.default, 'orgmode')
        opts.sources.providers['orgmode'] =
        {
            name = 'Orgmode',
            module = 'orgmode.org.autocompletion.blink',
        }
    end

    local has_codecompanion, _ = pcall(require, "codecompanion")
    if has_codecompanion then
        ---@diagnostic disable-next-line: param-type-mismatch
        table.insert(opts.sources.default, 'codecompanion')
    end

    -- Call plugin setup:
    require("blink.cmp").setup(opts)
end

function M.config_luasnip()
    local luasnip = require('luasnip')
    luasnip.add_snippets('c', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('cpp', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('tex', require('schilk.snippets.tex').snippets);
    luasnip.add_snippets('python', require('schilk.snippets.python').snippets);
    luasnip.add_snippets('rust', require('schilk.snippets.rust').snippets);
    luasnip.add_snippets('lua', require('schilk.snippets.lua').snippets);
    luasnip.add_snippets('json', require('schilk.snippets.json').snippets);
    luasnip.add_snippets('typst', require('schilk.snippets.typst').snippets);
    luasnip.add_snippets('bash', require('schilk.snippets.bash').snippets);
    luasnip.add_snippets('sh', require('schilk.snippets.bash').snippets);
    luasnip.add_snippets('org', require('schilk.snippets.org').snippets);
end

---@type LazyPluginSpec
M.spec = {

    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally

    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',

    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            config = M.config_luasnip
        }

    },

    -- use a release tag to download pre-built binaries
    -- version = 'v0.*',
    -- Build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo build --release',

    -- -- allows extending the providers array elsewhere in your config
    -- -- without having to redefine it
    -- opts_extend = { "sources.default" },
    --

    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
