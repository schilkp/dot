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
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
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

return M
