local M = {}

function M.config_highlight_on_yank()
  if vim.g.vscode then
    return
  end -- Disable in vscode-neovim

  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.hl.hl_op({ timeout = 40 })
    end,
    group = highlight_group,
    pattern = "*",
  })
end

local large_file_mode = false

-- FIXME: Make this per-buffer? Unlikely I need it enough to be worth it ;)
local function toggle_large_file_mode()
  if not large_file_mode then
    vim.print("Entering Large-File-Mode..")
    vim.cmd("syntax off")
    vim.cmd("filetype off")
    vim.cmd("set noundofile")
    vim.cmd("set noloadplugins")
    vim.cmd("set lazyredraw")
    vim.cmd("TSDisable *")
    large_file_mode = true
  else
    vim.print("Exiting Large-File-Mode..")
    vim.cmd("syntax on")
    vim.cmd("filetype on")
    vim.cmd("set undofile")
    vim.cmd("set loadplugins")
    vim.cmd("set nolazyredraw")
    vim.cmd("TSEnable *")
    large_file_mode = false
  end
end

function M.config_large_file_mode()
  if vim.g.vscode then
    return
  end -- Disable in vscode-neovim

  vim.keymap.set("n", "<leader>ml", toggle_large_file_mode, { silent = true, desc = "📁 Toggle Large-File-Mode" })
end

function M.config_unteach_bad_mappings()
  -- Helper to discourage bad habit mappings
  local function punish_key(key, mode, message)
    mode = mode or "n"
    message = message or ("Don't use " .. key .. "!")

    local ns = vim.api.nvim_create_namespace("flash_warning")
    vim.api.nvim_set_hl(ns, "Normal", { bg = "#550000", fg = "#ffffff" })
    vim.keymap.set(mode, key, function()
      vim.notify(message, vim.log.levels.ERROR)
      -- Highlight:
      vim.api.nvim_win_set_hl_ns(0, ns)
      vim.cmd("redraw")
      -- Reset highlight:
      vim.defer_fn(function()
        -- Check if the window is still valid before resetting
        if vim.api.nvim_get_current_win() then
          vim.api.nvim_win_set_hl_ns(0, 0)
        end
      end, 150)
    end, { desc = "Bad habit breaker: " .. key })
  end

  -- Unteach custom spelling mappings, use built-in:
  punish_key("<leader>sf", "n", "use 'z=' instead!")
  punish_key("<leader>ss", "n", "use ':set spell' instead!")
  punish_key("<leader>si", "n", "use 'zg' instead!")
end

return M
