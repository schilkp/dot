local M = {}

function M.config()
    vim.g.floaterm_keymap_toggle = '<leader>tt'
    vim.g.floaterm_keymap_new    = '<leader>tn'
    vim.g.floaterm_keymap_prev   = '<leader>tk'
    vim.g.floaterm_keymap_next   = '<leader>tj'
    vim.g.floaterm_keymap_kill   = '<leader>tx'
    vim.g.floaterm_height        = 0.95
    vim.g.floaterm_width         = 0.95
    vim.g.floaterm_opener        = 'tabe'

    -- vim.keymap.set({ 'n' }, '<leader>tt', ':FloatermToggle<CR>', { silent = true, desc = "Floaterm: Toggle" })
    -- vim.keymap.set({ 'n' }, '<leader>tn', ':FloatermNew<CR>', { silent = true, desc = "Floaterm: New" })
    -- vim.keymap.set({ 'n' }, '<leader>tk', ':FloatermPrev<CR>', { silent = true, desc = "Floaterm: Previous" })
    -- vim.keymap.set({ 'n' }, '<leader>tj', ':FloatermNext<CR>', { silent = true, desc = "Floaterm: Next" })
    -- vim.keymap.set({ 'n' }, '<leader>tx', ':FloatermKill<CR>', { silent = true, desc = "Floaterm: Kill" })
end

return M
