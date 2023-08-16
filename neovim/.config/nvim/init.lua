--[[
    TODO: LSP Saga? Noice?
    TODO python3 host prog:
       let g:python3_host_prog = '~/.config/nvim/nvim_env/bin/python'
    TODO Show Whitespace?
    TODO FloatTerm Maps
        let g:floaterm_keymap_toggle = '<leader>tt'
        let g:floaterm_keymap_new    = '<leader>tn'
        let g:floaterm_keymap_prev   = '<leader>tk'
        let g:floaterm_keymap_next   = '<leader>tj'
        let g:floaterm_keymap_kill   = '<leader>tx'
        let g:floaterm_height = 0.95
        let g:floaterm_width  = 0.95 let g:floaterm_opener = 'tabe'
    TODO finally learn :TERM (+ *Official Escape*)
    TODO LuaSnips

]]
--

-- Source basic VIM settings:
vim.cmd('source $HOME/.vimrc')

require('schilk.lazy').activate()

require('lazy').setup({

    -- LSP Config + LSP Utils
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
            'folke/neodev.nvim',
        },
    },

    -- CMP Autocomplete + LuaSnip:
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },

    -- Trouble:
    'folke/trouble.nvim',

    -- Which-Key:
    'folke/which-key.nvim',

    -- FloatTerm:
    'voldikss/vim-floaterm',


    -- OneDark:
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            require('onedark').setup {
                transparent = true,   -- Show/hide background
                ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden

                -- Lualine options --
                lualine = {
                    transparent = true, -- lualine center bar transparency
                },

                -- Custom Highlights --
                colors = {},     -- Override default colors
                highlights = {}, -- Override highlight groups

                -- Plugins Config --
                diagnostics = {
                    darker = true,      -- darker colors for diagnostic
                    undercurl = true,   -- use undercurl instead of underline for diagnostics
                    background = false, -- use background color for virtual text
                },
            }
            vim.cmd.colorscheme 'onedark'
        end,
    },


    -- LuaLine:
    'nvim-lualine/lualine.nvim',


    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function() -- Only install fzf-native extension if "make" is available.
                    return vim.fn.executable 'make' == 1
                end,
            },
            'nvim-tree/nvim-web-devicons'
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },


    "junegunn/fzf",
    'junegunn/fzf.vim',


    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            -- signs = {
            --     add = { text = '+' },
            --     change = { text = '~' },
            --     delete = { text = '_' },
            --     topdelete = { text = '‾' },
            --     changedelete = { text = '~' },
            -- },
            -- on_attach = function(bufnr)
            --     vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
            --         { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
            --     vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
            --         { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
            --     vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
            --         { buffer = bufnr, desc = '[P]review [H]unk' })
            -- end,
            current_line_blame = true,
        },
        lazy = false,
    },
    'tpope/vim-fugitive',

    'junegunn/vim-easy-align'
})


require("trouble").setup {}

require("which-key").setup {}

-- Setup neovim lua configuration
require('neodev').setup()

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- example to setup lua_ls and enable call snippets

lspconfig.clangd.setup({})

lspconfig.lua_ls.setup({
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

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- vim.o.completeopt = "menu,menuone" Was in my config + similar in kickstart, forget why?

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
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}



-- LSP Navigation Binds:
vim.keymap.set({ 'n' }, '<leader>gd', vim.lsp.buf.definition, { silent = true, desc = "LSP: Goto Definition." })         -- TODO make saga?
vim.keymap.set({ 'n' }, '<leader>gD', vim.lsp.buf.declaration, { silent = true, desc = "LSP: Goto Declaration." })
vim.keymap.set({ 'n' }, '<leader>gr', vim.lsp.buf.references, { silent = true, desc = "LSP: Goto References." })         -- TODO mage saga?
vim.keymap.set({ 'n' }, '<leader>gI', vim.lsp.buf.implementation, { silent = true, desc = "LSP: Goto Implementation." }) -- TODO make telescope?
vim.keymap.set({ 'n' }, '<leader>gi', vim.lsp.buf.incoming_calls, { silent = true, desc = "LSP: Goto Incoming Calls." }) -- TODO make SAGA?
vim.keymap.set({ 'n' }, '<leader>gt', vim.lsp.buf.type_definition, { silent = true, desc = "LSP: Type Definition." })    -- TODO make SAGA?
vim.keymap.set({ 'n' }, '<leader>go', vim.lsp.buf.outgoing_calls, { silent = true, desc = "LSP: Goto Outgoing Calls." }) -- TODO make SAGA?
vim.keymap.set({ 'n' }, '<leader>gh', ':ClangdSwitchSourceHeader<CR>',
    { silent = true, desc = "LSP: Switch Header/Source." })

-- LSP Action Binds:
vim.keymap.set({ 'n' }, '<leader>rn', vim.lsp.buf.rename, { silent = true, desc = "LSP: Rename." })
vim.keymap.set({ 'n' }, '<leader>F', vim.lsp.buf.format, { silent = true, desc = "LSP: Format." })
vim.keymap.set({ 'n' }, '<leader>ga', vim.lsp.buf.code_action, { silent = true, desc = "LSP: Code Actions" })

-- Diagnostics:
vim.keymap.set({ 'n' }, '<leader>gH', require('trouble').toggle, { silent = true, desc = "LSP: Diagnostics" })
vim.keymap.set({ 'n' }, '<leader>k', vim.lsp.buf.hover, { silent = true, desc = "LSP: Documentation" })

-- FLOATERM


-- LUALINE:

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', { 'diagnostics', colored = false } },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress', file_prog }, -- TODO? Undefined?
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {}, winbar = {},
    inactive_winbar = {},
    extensions = {}
}


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ timeout = 40 })
    end,
    group = highlight_group,
    pattern = '*',
})

-- Telescope:
-- [[ Configure Telescope ]]

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {}
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>o', require('telescope.builtin').find_files, { desc = 'Open File.' })
local function find_in_parent()
    require('telescope.builtin').find_files({ find_command = { "rg", "--files", "--color", "never", ".." } })
end
vim.keymap.set('n', '<leader>O', find_in_parent, { desc = 'Open File in Parent Dir.' })
vim.keymap.set('n', '<leader>i', require('telescope.builtin').git_files, { desc = 'Open Git File.' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').oldfiles, { desc = 'Open Recent File.' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Open Buffer.' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>p', ':Rg<CR>', { desc = '[S]earch [H]elp' })

-- TODO TELESCOPE RIP GREP!

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fl', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
--
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })


local function telescope_config_files()
    require('telescope.builtin').find_files({
        search_dirs = { "~/.config/nvim/init.lua", "~/.config/nvim/plugin/", "~/.config/nvim/lua/", "~/.vimrc" } })
end
vim.keymap.set('n', '<leader>=e', telescope_config_files, { desc = 'Open Buffer.' })

local function telescope_notes()
    require('telescope.builtin').find_files({ search_dirs = { "~/notes" } })
end
vim.keymap.set('n', '<leader>ww', telescope_notes, { desc = 'Open Buffer.' })


-- Comment:
require('Comment').setup()


-- Easy Align:
vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)', { silent = true, desc = "EasyAlign", remap=true})

