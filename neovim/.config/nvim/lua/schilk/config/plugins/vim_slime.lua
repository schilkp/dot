local M = {}

local function print_slime_note(always)
  if always or vim.b.slime_config == nil or vim.b.slime_conig == "" then
    vim.fn.input(
      "Default TMUX socket: 'default'\nTMUX target pane syntax:\n':i.j'  - Current session, window i, pane j\n'h:i.j' - Session h, window i, pane j\n[Press Enter]"
    )
  end
end

local function slime_region_send()
  print_slime_note(false)
  vim.cmd("normal")
  vim.cmd("'<,'>SlimeSend")
end

local function slime_paragraph_send()
  print_slime_note(false)
  vim.cmd('execute "normal \\<Plug>SlimeParagraphSend"')
end

local function slime_config()
  print_slime_note(true)
  vim.cmd("SlimeConfig")
end

function M.config()
  -- Send to tmux:
  vim.cmd('let g:slime_target = "tmux"')

  -- Disable default mappings:
  vim.cmd("let g:slime_no_mappings = 1")
  vim.cmd("nmap <Plug>NoSlimeParagraphSend <Plug>SlimeParagraphSend")
  vim.cmd("nmap <Plug>NoSlimeRegionSend <Plug>SlimeRegionSend")
  vim.cmd("nmap <Plug>NoSlimeConfig <Plug>SlimeConfig")
  -- Mappings:
  vim.keymap.set(
    { "n" },
    "<C-c><C-c>",
    slime_paragraph_send,
    { silent = true, desc = "Slime: Send current paragraph.", noremap = true }
  )
  vim.keymap.set(
    { "x" },
    "<C-c><C-c>",
    slime_region_send,
    { silent = true, desc = "Slime: Send current selection.", noremap = true }
  )
  vim.keymap.set({ "n" }, "<C-c>v", slime_config, { silent = true, desc = "Slime: Config.", noremap = true })
end

---@type LazyPluginSpec
M.spec = {
  "jpalardy/vim-slime",
  config = M.config,
  cond = not vim.g.vscode, -- Disable in vscode-neovim
}

return M
