local M = {}

function M.config()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "hyprlang" },

        highlight = {
            enable = true,
            disable = function(lang, buf)
                return lang ~= "hyprlang"
            end,
        },

    }
    vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    })
end

return M
