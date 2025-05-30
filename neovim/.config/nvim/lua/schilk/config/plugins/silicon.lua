local M = {}

function M.config()
    require("nvim-silicon").setup({
        font = "JetbrainsMono NF=34"
    })
end

---@type LazyPluginSpec
M.spec = {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = M.config,
}

return M
