local M = {}

function M.config()
    -- LuaSnip
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    -- Call plugin setup:

    require("blink.cmp").setup({
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
                selection = "auto_insert"
            },

            trigger = {
                show_on_keyword = true,
                show_on_trigger_character = true,
            },

            documentation = {
                auto_show = true,
            },

            ghost_text = {
                enabled = true,
            },

            -- Disable auto-show in org-roam-select panel:
            menu = { auto_show = function(ctx) return ctx.mode ~= 'org-roam-select' end }
        },

        snippets = {
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },


        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'luasnip', 'buffer', 'orgmode', 'codecompanion' },
            -- optionally disable cmdline completions
            cmdline = {},
            providers = {
                orgmode = {
                    name = 'Orgmode',
                    module = 'orgmode.org.autocompletion.blink',
                },
                codecompanion = {
                    name = "CodeCompanion",
                    module = "codecompanion.providers.completion.blink",
                    score_offset = 10,
                },

            }
        },

        signature = { enabled = true } -- experimental
    }
    )
end

function M.config_luasnip()
    local luasnip = require('luasnip')
    luasnip.add_snippets('c', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('cpp', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('tex', require('schilk.snippets.tex').snippets);
    luasnip.add_snippets('python', require('schilk.snippets.python').snippets);
    luasnip.add_snippets('rust', require('schilk.snippets.rust').snippets);
    luasnip.add_snippets('lua', require('schilk.snippets.lua').snippets); luasnip.add_snippets('json',
        require('schilk.snippets.json').snippets);
end

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
