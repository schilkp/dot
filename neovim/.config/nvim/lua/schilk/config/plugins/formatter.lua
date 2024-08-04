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
            html = {
                require("formatter.filetypes.html").prettier,
            },
            vue = {
                require("formatter.filetypes.vue").prettier,
            },
            ["*"] = {
                require("formatter.filetypes.any").remove_trailing_whitespace,
            },
        },
    })

    -- Format whole file
    local function format()
        vim.lsp.buf.format()
        vim.cmd("Format")
    end

    -- Format selection
    local function format_selection()
        -- Format using LSP:
        vim.lsp.buf.format()

        -- Note: formatter.nvim supports range-based selection using:
        --         :'<,'>Format
        --       But the "'<" and "'>" marks are not set until visual mode
        --       is exited, which happends when EX mode is opened by pressing
        --       ":". Since there is no simple way of exiting visual mode
        --       in an blocking/sync fashion, we instead manually find the
        --       first and last line of the selection, and pass those
        --       numbers directly.

        -- Determine range of lines selected:
        local vstart = vim.fn.getpos("v")
        local vcurrent = vim.fn.getcurpos()
        local line_start = vstart[2]
        local line_current = vcurrent[2]

        -- Handle up-down vs down-up selection by the line numbers:
        local line_first = line_start
        local line_last = line_current
        if (line_start > line_current) then
            line_first = line_current
            line_last = line_start
        end

        -- Format using formatter.nvim:
        vim.cmd(tostring(line_first) .. "," .. tostring(line_last) .. " Format")

        -- Exit visual mode:
        local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'm', false)
    end

    vim.keymap.set({ "n" }, "<leader>F", format, { silent = true, desc = "🧹 Format." })
    vim.keymap.set({ "v" }, "gf", format_selection, { silent = true, desc = "🧹 Format." })
end

return M
