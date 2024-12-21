-- Source basic VIM settings:
vim.cmd('source $HOME/.vimrc')

-- Disable netrw (Recommended by nvim tree):
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Activate/install package manager:
require('schilk.lazy').activate()

-- Plugins:
require('lazy').setup({

    -- [[ COLOR SCHEMES ]] --
    -- require('schilk.config.plugins.catppuccin').spec,
    require('schilk.config.plugins.onedark').spec,

    -- [[ UI ]] --
    -- Keybind help:
    require('schilk.config.plugins.whichkey').spec,
    -- Diagnostics window:
    require('schilk.config.plugins.trouble').spec,
    -- File tree:
    require('schilk.config.plugins.nvim_tree').spec,
    -- Undo tree:
    require('schilk.config.plugins.undotree').spec,
    -- File outline:
    require('schilk.config.plugins.aerial').spec,
    -- Status bar:
    require('schilk.config.plugins.lualine').spec,
    -- Indent guides:
    require('schilk.config.plugins.indent_blankline').spec,
    -- Color code visualizer:
    require('schilk.config.plugins.colorizer').spec,
    -- Top nav bar:
    require('schilk.config.plugins.barbecue').spec,
    -- Git status sidebar:
    require('schilk.config.plugins.gitsigns').spec,

    -- [[ TOOLS ]] --
    -- Bulk file manage:
    require('schilk.config.plugins.dirbuf').spec,
    -- Fuzzy finding:
    require('schilk.config.plugins.fzflua').spec,
    require('schilk.config.plugins.telescope').spec,
    -- In-browser markdown preview
    require('schilk.config.plugins.markdown_preview').spec,
    -- Code-to-image render:
    require('schilk.config.plugins.silicon').spec,
    -- Documentation boilerplate generation:
    require('schilk.config.plugins.neogen').spec,
    -- Code formatting:
    require('schilk.config.plugins.formatter').spec,
    -- Push-to-REPL:
    require('schilk.config.plugins.vim_slime').spec,
    -- Text alignment:
    require('schilk.config.plugins.easy_align').spec,
    -- TEX integration:
    require('schilk.config.plugins.vimtex').spec,
    -- Make me suffer:
    require('schilk.config.plugins.hardtime').spec,
    -- Indentation as text object:
    'michaeljsmith/vim-indent-object',
    -- Got integration:
    'tpope/vim-fugitive',
    -- Make me suffer:
    require('schilk.config.plugins.orgmode').spec,

    -- [[ LSP/COMPLETION ]] --
    -- LSP:
    require('schilk.config.plugins.lsp').spec,
    -- Completion + Snippets:
    require('schilk.config.plugins.blink_cmp').spec,


    -- [[ FILE TYPES ]] --
    'NoahTheDuke/vim-just',
    'mustache/vim-mustache-handlebars',
    'hjson/vim-hjson',
    'rust-lang/rust.vim',

    -- [[ OTHER ]] --
    require('schilk.config.plugins.treesitter').spec,
})

-- Config:
require('schilk.config.nvim').config_highlight_on_yank()
require('schilk.config.nvim').config_large_file_mode()
require('schilk.config.py3_env').config_py3_env()
require('schilk.config.spellfiles').config_spellfiles()

if vim.g.vscode then
    require('schilk.config.vscode').setup()
end

-- Custom scripts/utils:
require('schilk.utils.sv_module_instantiation').setup()
require('schilk.utils.notes').setup()
require('schilk.utils.ssh_clip').setup()
