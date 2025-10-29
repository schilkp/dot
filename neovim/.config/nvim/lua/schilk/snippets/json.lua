local M = {}

local ls = require("luasnip")

-- stylua: ignore start
M.snippets = {
  ls.parser.parse_snippet({ trig = "st_opt" }, [[/opt/st/stm32cubeclt/STLink-gdb-server/bin/ST-LINK_gdbserver]]),
}
-- stylua: ignore end

return M
