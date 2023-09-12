-- Source basic VIM settings:
vim.cmd('source $HOME/.vimrc')

-- Disable netrw (Recommended by nvim tree):
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
            -- rust:
            'simrat39/rust-tools.nvim',
            'rust-lang/rust.vim',
            -- clangd:
            'p00f/clangd_extensions.nvim'
        },
        config = require('schilk.config.lsp').config
    },
    -- CMP Autocomplete + LuaSnip:
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip',
                config = require('schilk.config.lua_snip').config
            }
        },

        config = require('schilk.config.cmp').config
    },
    -- Trouble:
    {
        'folke/trouble.nvim', opts = {}
    },
    -- Which-Key:
    {
        'folke/which-key.nvim',
        config = require('schilk.config.whichkey').config
    },
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
            'nvim-tree/nvim-web-devicons',
            'nvim-telescope/telescope-symbols.nvim'
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
    },
    -- Vim Indent Objects:
    'michaeljsmith/vim-indent-object',
    -- VimTEX:
    {
        'lervag/vimtex',
        config = require('schilk.config.vimtex').config,
    },
    -- Justfile syntax highlighting:
    'NoahTheDuke/vim-just',
    -- Slime: Push-to-REPL:
    {
        'jpalardy/vim-slime',
        config = require('schilk.config.vim_slime').config
    },
    -- Barbecue top status/location line:
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    -- NVIM Tree:
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = require('schilk.config.nvim_tree').config
    },
    {
        'elihunter173/dirbuf.nvim',
        config = require('schilk.config.dirbuf').config
    },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = require('schilk.config.hardtime').config
    },
    {
        'mhartington/formatter.nvim',
        config = require('schilk.config.formatter').config
    }
})

require('schilk.config.nvim').config_py3_env()
require('schilk.config.nvim').config_highlight_on_yank()
require('schilk.config.nvim').config_floatterm_replacement()
require('schilk.config.nvim').config_large_file_mode()
require('schilk.config.nvim').config_no_jk_mapping_trainig()

require('schilk.utils.sv_module_instantiation').setup()
