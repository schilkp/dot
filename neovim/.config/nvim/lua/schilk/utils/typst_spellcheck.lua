local M = {}
--- @param root_file_name string|nil
function M.typst_spell_check(root_file_name)
    if not root_file_name then
        root_file_name = "main.typ"
    end

    local paths = vim.fs.find(root_file_name, { stop = vim.env.HOME })
    local root_dir = vim.fs.dirname(paths[1])

    if root_dir then
        vim.notify("Starting in " .. root_dir)
        vim.lsp.start({
            cmd = { 'typst-languagetool-lsp' },
            filetype = { 'typst' },
            root_dir = root_dir,
            init_options = {
                backend = "bundle", -- "bundle" | "jar" | "server"
                -- jar_location = "path/to/jar/location"
                -- host = "http://127.0.0.1",
                -- port = "8081",
                root = root_dir,
                main = root_dir .. "/" .. root_file_name,
                languages = { de = "de-DE", en = "en-US" }
            },
        })
    else
        vim.notify("Main file `" .. root_file_name .. "` not found.", vim.log.levels.ERROR)
    end
end

function M.TypstSpellCheckCmd(args)
    if #args.fargs == 0 then
        M.typst_spell_check()
        return
    end
    if #args.fargs == 1 then
        M.typst_spell_check(args.fargs[1])
        return
    end
    vim.print("Expect zero or one args")
end

function M.setup()
    vim.api.nvim_create_user_command('TypstSpellCheck', M.TypstSpellCheckCmd, { nargs = "?" })
end

return M
