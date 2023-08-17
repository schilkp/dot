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

-- Activate/install package manager:
require('schilk.lazy').activate()

-- Plugins:
require('lazy').setup({
    -- LSP Config + LSP Utils
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
            'folke/neodev.nvim',
        },
        config = require('schilk.config.lsp').config
    },
    -- CMP Autocomplete + LuaSnip:
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = require('schilk.config.cmp').config
    },
    -- Trouble:
    {
        'folke/trouble.nvim',
        lazy = false,
        config = true
    },
    -- Which-Key:
    {
        'folke/which-key.nvim',
        lazy = false,
        config = true,
    },
    -- FloatTerm:
    'voldikss/vim-floaterm',
    -- OneDark Colorscheme:
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = require('schilk.config.onedark').config
    },
    -- LuaLine:
    {
        'nvim-lualine/lualine.nvim',
        opts = require('schilk.config.lualine').opts()
    },
    -- Commenting:
    { 'numToStr/Comment.nvim', opts = {} },
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
        config = require('schilk.config.telescope').config
    },
    -- Treesitter:
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    -- FZF:
    "junegunn/fzf",
    'junegunn/fzf.vim',
    -- Git Signs:
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = require('schilk.config.gitsigns').opts()
    },
    -- Git Integration:
    'tpope/vim-fugitive',
    -- Easy Align:
    {
        'junegunn/vim-easy-align',
        config = require('schilk.config.easy_align').config,
    }
})

require('schilk.config.nvim').config_highlight_on_yank()
