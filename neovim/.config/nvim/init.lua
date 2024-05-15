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
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                config = require('schilk.config.plugins.fidget').config
            },
            'folke/neodev.nvim',
            -- rust:
            'simrat39/rust-tools.nvim',
            'rust-lang/rust.vim',
            -- clangd:
            'p00f/clangd_extensions.nvim',
            -- json/yaml schemas:
            'b0o/schemastore.nvim',
        },
        config = require('schilk.config.plugins.lsp').config
    },
    -- Fuzzy finding:
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = require('schilk.config.plugins.fzflua').config
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
                config = require('schilk.config.plugins.lua_snip').config
            }
        },
        config = require('schilk.config.plugins.cmp').config
    },
    -- Trouble:
    {
        'folke/trouble.nvim', opts = {}
    },
    -- Which-Key:
    {
        'folke/which-key.nvim',
        config = require('schilk.config.plugins.whichkey').config
    },
    -- -- OneDark Colorscheme:
    -- {
    --     -- Theme inspired by Atom
    --     'navarasu/onedark.nvim',
    --     priority = 1000,
    --     config = require('schilk.config.plugins.onedark').config
    -- },
    {
        "catppuccin/nvim",
        priority = 1000,
        name = "catppuccin",
        config = require('schilk.config.plugins.catppuccin').config
    },

    -- LuaLine:
    {
        'nvim-lualine/lualine.nvim',
        opts = require('schilk.config.plugins.lualine').opts()
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
        config = require('schilk.config.plugins.telescope').config
    },
    -- Treesitter:
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = require('schilk.config.plugins.treesitter').config
    },
    -- Git Signs:
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = require('schilk.config.plugins.gitsigns').opts()
    },
    -- Git Integration:
    'tpope/vim-fugitive',
    -- Easy Align:
    {
        'junegunn/vim-easy-align',
        config = require('schilk.config.plugins.easy_align').config,
    },
    -- Vim Indent Objects:
    'michaeljsmith/vim-indent-object',
    -- VimTEX:
    {
        'lervag/vimtex',
        config = require('schilk.config.plugins.vimtex').config,
    },
    -- Justfile syntax highlighting:
    'NoahTheDuke/vim-just',
    -- HJSON syntax highlighting:
    'hjson/vim-hjson',
    -- Slime: Push-to-REPL:
    {
        'jpalardy/vim-slime',
        config = require('schilk.config.plugins.vim_slime').config
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
        config = require('schilk.config.plugins.nvim_tree').config
    },
    -- NVIM Outline:
    {
        "hedyhli/outline.nvim",
        config = require('schilk.config.plugins.nvim_outline').config
    },
    {
        'elihunter173/dirbuf.nvim',
        config = require('schilk.config.plugins.dirbuf').config
    },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = require('schilk.config.plugins.hardtime').config
    },
    {
        'mhartington/formatter.nvim',
        config = require('schilk.config.plugins.formatter').config
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = require('schilk.config.plugins.neogen').config,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = require('schilk.config.plugins.indent_blankline').config,
    },
    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = require('schilk.config.plugins.silicon').config,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = require('schilk.config.plugins.markdown_preview').config
    }
})

-- Config:
require('schilk.config.nvim').config_highlight_on_yank()
require('schilk.config.nvim').config_floatterm_replacement()
require('schilk.config.nvim').config_large_file_mode()
require('schilk.config.py3_env').config_py3_env()
require('schilk.config.spellfiles').config_spellfiles()

-- Custom scripts/utils:
require('schilk.utils.sv_module_instantiation').setup()
require('schilk.utils.notes').setup()
