local M = {}

function M.config(lsp_config_opts)
    lsp_config_opts.standalone = true
    require('rust-tools').setup {
        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = lsp_config_opts
    }
end

return M
