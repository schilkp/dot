local M = {}

function M.setup()
  local sv_modules = require("schilk.utils.macros.sv.module_instantiation")
  sv_modules.setup()
  local sv_flip = require("schilk.utils.macros.sv.flip_ports")
  sv_flip.setup()
end

return M
