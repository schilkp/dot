--[[

NOTE: Originally from `nvim-config-local` by klen, which is released under the
MIT License

https://github.com/klen/nvim-config-local

I inlined this project both because I wanted to make some modifications and
because I wanted it to always be available - even before Lazy loads. This way
I can also inject local lazy plugins.

---

MIT License

Copyright (c) 2021 klen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]

local M = {}
local HashMap = require "schilk.local_config.hashmap"

--//===--------------------------------------------------------------------===//
--// State
--//===--------------------------------------------------------------------===//

local hashmap

--//===--------------------------------------------------------------------===//
--// Config Constants
--//===--------------------------------------------------------------------===//

M.CONFIG_FILE_NAMES = { ".schilk.nvim.lua" };
M.HASH_FILE = vim.fs.joinpath(vim.fn.stdpath("data"), "trusted_local_configs");
M.CONFIG_SAMPLES_DIR = vim.fs.joinpath(vim.fn.stdpath("config"), "example_local_configs");

--//===--------------------------------------------------------------------===//
--// Utils
--//===--------------------------------------------------------------------===//

local function prompt_choice(msg, choices)
    local _, choice = pcall(vim.fn.confirm, "[local_config]: " .. msg, choices, 1)
    return choice
end

local function map(t, f)
    local t1 = {}
    local t_len = #t
    for i = 1, t_len do
        t1[i] = f(t[i])
    end
    return t1
end

local function info(msg)
    vim.notify("[local_config]: " .. msg, vim.log.levels.INFO)
end

local function warn(msg)
    vim.notify("[local_config]: " .. msg, vim.log.levels.WARN)
end

local function error(msg)
    vim.notify("[local_config]: " .. msg, vim.log.levels.ERROR)
end

--//===--------------------------------------------------------------------===//
--// Commands: Mark trusted/untrusted
--//===--------------------------------------------------------------------===//

---Deny local configuration
---@param filename? string: a file name
function M.deny(filename)
    filename = filename or M.lookup()
    if not filename then
        return error("Config file not found: " .. table.concat(M.CONFIG_FILE_NAMES, ","))
    end
    hashmap:write(filename, "!")
    info('Config file "' .. filename .. '" marked as denied')
end

---Mark the given filename as trusted
--- @param filename string: a file name
function M.trust(filename)
    hashmap:trust(filename)
    info('Config file "' .. filename .. '" marked as trusted.')
end

--//===--------------------------------------------------------------------===//
--// Commands: Edit
--//===--------------------------------------------------------------------===//

---Confirm a config file on save
function M.confirm()
    local filename = vim.fn.expand("%:p")
    local state = hashmap:verify(filename)
    if state ~= "t" then
        local choice = prompt_choice(
            "Do you want to mark this config as trusted: " .. filename .. "?",
            "&Yes\n&No"
        )
        if choice == 1 then
            return M.trust(filename)
        else
            return M.deny(filename)
        end
    end
end

---Confirm a config file on save
function M.copy_to_samples()
    local filename = vim.fn.expand("%:p")

    if vim.fn.isdirectory(M.CONFIG_SAMPLES_DIR) == 0 then
        vim.fn.mkdir(M.CONFIG_SAMPLES_DIR, "p")
    end

    -- Prompt user for sample name
    vim.ui.input({
        prompt = "Enter sample name: ",
    }, function(name)
        if not name or name == "" then
            vim.notify("Sample name is required", vim.log.levels.WARN)
            return
        end

        local dest = M.CONFIG_SAMPLES_DIR .. "/" .. name .. ".lua"
        local result = vim.fn.writefile(vim.fn.readfile(filename), dest)

        if result == 0 then
            vim.notify("File copied to " .. dest, vim.log.levels.INFO)
        else
            vim.notify("Failed to copy file", vim.log.levels.ERROR)
        end
    end)
end

---Edit local configuration
--- @param filename? string: a file name
function M.edit(filename)
    filename = filename or M.lookup() or M.CONFIG_FILE_NAMES[1]
    vim.api.nvim_command("edit " .. filename)
end

---Edit the hash file
function M.edit_hash_file()
    vim.api.nvim_command("edit " .. M.HASH_FILE)
end

---Look for config file
function M.lookup()
    for _, filename in ipairs(M.CONFIG_FILE_NAMES) do
        filename = vim.fn.findfile(filename, ".;")
        if filename ~= "" then
            return vim.fn.fnamemodify(filename, ":p")
        end
    end
end

---Look for a config if it exist in the current directory, and verify if it is trusted.
---If not, prompt the user on what they want to do.
function M.find_trusted_local_config()
    local filename = M.lookup()
    if filename then
        local trust_state = hashmap:verify(filename)

        if trust_state == "t" then
            info('Trusted local config file "' .. filename .. '" found.')
            return filename
        elseif trust_state == "u" then
            -- Prompt
            local msg = 'Unknown config file found: "' .. vim.fn.fnamemodify(filename, ":~:.") .. '"'
            local choice = prompt_choice(msg, "&ignore\n&view\n&deny\n&allow")

            if choice == 2 then
                M.edit(filename)
                return ""
            elseif choice == 3 then
                M.deny(filename)
                return ""
            elseif choice == 4 then
                M.trust(filename)
                return filename
            end
        else
            -- Config denied.
            warn('Local config file "' .. filename .. '" is denied and has not been loaded.')
            return ""
        end
    end
    return ""
end

function M.source()
    local filename = M.find_trusted_local_config();
    if not filename or filename == "" then
        return
    end
    vim.api.nvim_command("source " .. filename)
end

function M.setup()
    hashmap = HashMap:init(M.HASH_FILE)

    vim.api.nvim_command "command! LocalEdit lua require'schilk.local_config'.edit()<CR>"
    vim.api.nvim_command "command! LocalEditDB lua require'schilk.local_config'.edit_hash_file()<CR>"
    vim.api.nvim_command "command! LocalTrust lua require'schilk.local_config'.trust(vim.fn.expand('%:p'))<CR>"
    vim.api.nvim_command "command! LocalDeny lua require'schilk.local_config'.deny()<CR>"
    vim.api.nvim_command "command! LocalSaveAsSample lua require'schilk.local_config'.copy_to_samples()<CR>"

    -- local au = vim.api.nvim_create_autocmd
    -- local augroup = vim.api.nvim_create_augroup("local-config", { clear = true })

    -- Confirm local configs
    -- au("BufWritePost", {
    --     group = augroup,
    --     desc = "Confirm local configs",
    --     pattern = table.concat(
    --         map(M.CONFIG_FILE_NAMES, function(f)
    --             return "**/" .. f
    --         end),
    --         ","
    --     ),
    --     nested = true,
    --     callback = M.confirm,
    -- })
end

return M
