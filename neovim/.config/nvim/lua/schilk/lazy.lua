local M = {}

function M.activate()
  -- Install lazy package manager if not already installed
  --    https://github.com/folke/lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.print("Installing lazy.nvim...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
    vim.print("Done!")
  end
  vim.opt.rtp:prepend(lazypath)
end

function M.lazy_settings()
  return {
    dev = {
      path = "~/reps/",
    },
    install = {
      colorscheme = { "onedark", "habamax" },
    },
  }
end

-- Check whether a plugin is present in the lazy spec WITHOUT loading it.
function M.has_plugin(name)
  local ok, cfg = pcall(require, "lazy.core.config")
  return ok and cfg.plugins[name] ~= nil
end

return M
