local M = {}

-- Wrapper for default presets that sets the cwd of the formatter execution
-- to the location of the file opened in the buffer, not the cwd of nvim:
local function set_cwd_to_buffer(base_config)
    return function()
        local util = require("formatter.util")
        local path = vim.fs.dirname(util.get_current_buffer_file_path())
        base_config["cwd"] = path
        return base_config
    end
end

function M.config()
    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
            yaml = {
                require("formatter.filetypes.yaml").prettier,
            },
            python = {
                set_cwd_to_buffer(require("formatter.filetypes.python").autopep8()),
                set_cwd_to_buffer(require("formatter.filetypes.python").isort()),
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
