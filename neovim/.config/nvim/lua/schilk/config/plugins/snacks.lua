local M = {}

function M.config()
  require("snacks").setup({
    image = {
      enabled = true,
    },
  })

  vim.api.nvim_create_user_command("SnacksImageToggle", function()
    local image = require("snacks").image

    image.config.enabled = not image.config.enabled

    if image.config.enabled then
      -- Re-enable: clear the attached flag and reattach
      local buf = vim.api.nvim_get_current_buf()
      vim.b[buf].snacks_image_attached = false
      image.doc.attach(buf)
      vim.notify("Images enabled", vim.log.levels.INFO)
    else
      -- Disable: clean up all image placements and clear autocommands
      image.placement.clean()

      -- Clear autocommands for all buffers
      local bufs = vim.api.nvim_list_bufs()
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) then
          pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.inline." .. buf)
          pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.doc." .. buf)
          vim.b[buf].snacks_image_attached = false
        end
      end

      vim.notify("Images disabled", vim.log.levels.INFO)
    end
  end, { desc = "Toggle image rendering" })
end

---@type LazyPluginSpec
M.spec = {
  "folke/snacks.nvim",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
