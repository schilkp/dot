local M = {}

function M.setup()
	local sv_modules = require("schilk.utils.macros.sv.module_instantiation")
	sv_modules.setup()
end

return M
