local M = {}

function M.toggle()
  local winnr = vim.api.nvim_get_current_win()

  if not vim.w[winnr].conceal_did_unconceal then
    vim.print("Unconcealing..")
    vim.w[winnr].conceal_saved_level = vim.api.nvim_get_option_value("conceallevel", { win = winnr })
    vim.api.nvim_set_option_value("conceallevel", 0, { win = winnr })
    vim.w[winnr].conceal_did_unconceal = true
  else
    vim.print("Concealing..")
    vim.api.nvim_set_option_value("conceallevel", vim.w[winnr].conceal_saved_level, { win = winnr })
    vim.w[winnr].conceal_did_unconceal = false
  end
end

function M.setup()
  vim.keymap.set("n", "<leader>mh", M.toggle, { silent = true, desc = "💡 Toggle conceallevel for current window." })
end

return M
