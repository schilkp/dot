local M = {}

function M.config()
    require("silicon").setup({
        font = "JetbrainsMono NF=34"
    })
end

M.spec = {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = M.config,
}

return M
