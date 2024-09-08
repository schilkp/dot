local M = {}

function M.config()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    -- Have signcolumn always present and with space for two signs:
    vim.o.signcolumn = "yes:2"
    -- Limit max pop-up menue (completions) height:
    vim.o.pumheight = 20

    cmp.setup {
        -- Snippet engine (required!):
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        -- Key bindings::
        mapping = cmp.mapping.preset.insert {
            ['<C-p>'] = cmp.mapping.scroll_docs(-4),
            ['<C-n>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false, -- Do not auto-select a completion item
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if luasnip.locally_jumpable() then
                    luasnip.jump(1)
                elseif cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                elseif cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },

        -- Sources::
        sources = {
            { name = 'nvim_lsp',               priority = 50 },
            { name = 'luasnip' },
            { name = 'path',                   max_item_count = 5 },
            { name = 'buffer',                 max_item_count = 5 },
            { name = 'nvim_lsp_signature_help' }
        },
    }
end

function M.config_luasnip()
    local luasnip = require('luasnip')
    luasnip.add_snippets('c', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('cpp', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('tex', require('schilk.snippets.tex').snippets);
    luasnip.add_snippets('python', require('schilk.snippets.python').snippets);
    luasnip.add_snippets('rust', require('schilk.snippets.rust').snippets);
    luasnip.add_snippets('lua', require('schilk.snippets.lua').snippets); luasnip.add_snippets('json', require('schilk.snippets.json').snippets);
end

M.spec = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'saadparwaiz1/cmp_luasnip',
        {
            'L3MON4D3/LuaSnip',
            config = M.config_luasnip
        }
    },
    config = M.config
}

return M
