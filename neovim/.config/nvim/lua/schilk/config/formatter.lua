local M = {}

function M.config()
    -- Utilities for creating configurations
    local util = require("formatter.util")

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
            python = {
                require("formatter.filetypes.python").autopep8,
                require("formatter.filetypes.python").isort,
            },
            ocaml = {
                require("formatter.filetypes.ocaml").ocamlformat,
            },
            ["*"] = {
                require("formatter.filetypes.any").remove_trailing_whitespace,
            },
        },
    })

    local function format()
        vim.lsp.buf.format()
        vim.cmd("Format")
    end

    vim.keymap.set({ "n" }, "<leader>F", format, { silent = true, desc = "🧹 Format." })
end

return M
