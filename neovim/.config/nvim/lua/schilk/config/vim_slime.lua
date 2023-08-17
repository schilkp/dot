local M = {}

function M.config()
    vim.cmd("let g:slime_target = \"tmux\"")
    vim.cmd("nnoremap <C-c>t :let g:slime_target = \"x11\" <CR>")
end

return M
