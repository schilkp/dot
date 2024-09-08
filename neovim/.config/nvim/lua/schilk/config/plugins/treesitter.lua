local M = {}

function M.config()
    local ts_highlight_langs = { "hyprlang", "markdown" };

    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "hyprlang", "markdown" },

        highlight = {
            enable = true,
            disable = function(lang, _) -- (lang, buf)
                for _, en_lang in pairs(ts_highlight_langs) do
                    if lang == en_lang then
                        return false;
                    end
                end
                return true;
            end,
        },

    }
    vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    })
end

M.spec = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = M.config
}

return M
