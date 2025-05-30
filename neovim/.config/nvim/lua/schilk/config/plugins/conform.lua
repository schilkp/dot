local M = {}

function M.config()
    -- Call plugin setup:

    require("conform").setup({
        -- require("conform").setup({
        --   formatters_by_ft = {
        --     -- Conform will run multiple formatters sequentially
        --     python = { "isort", "black" },
        --     -- You can customize some of the format options for the filetype (:help conform.format)
        --     rust = { "rustfmt", lsp_format = "fallback" },
        --     -- Conform will run the first available formatter
        --     javascript = { "prettierd", "prettier", stop_after_first = true },
        --   },
        -- })

        formatters_by_ft = {
            lua = { "stylua" },
            yaml = { "yamlfmt" },
            python = { "autopep8", "isort" },
            ocaml = { "ocamlformat" },
            html = { "prettier" },
            vue = { "prettier" },
            markdown = { "mdformat" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            typst = { "typstyle" },
            bzl = { "buildifier" },
            ["*"] = { "trim_whitespace" },
        },

        default_format_opts = {
            lsp_format = "first",
        },

    })

    vim.keymap.set({ "n" }, "<leader>F", require('conform').format, { silent = true, desc = "🧹 Format." })
    vim.keymap.set({ "v" }, "gf", require('conform').format, { silent = true, desc = "🧹 Format." })
end

---@type LazyPluginSpec
M.spec = {
    'stevearc/conform.nvim',
    config = M.config,
    cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
