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

return M
