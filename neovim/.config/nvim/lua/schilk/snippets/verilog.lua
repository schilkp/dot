-- stylua: ignore
local M = {}
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

M.snippets = {
    s({ trig = "always_ff" }, {
        t({ "always_ff @(posedge clk_i or negedge rst_ni) begin", "" }),
        t({ "  if (!rst_ni) begin", "" }),
        t({ "    " }), i(0), t({ "", "" }),
        t({ "  end else begin", "" }),
        t({ "    ", "" }),
        t({ "  end", "" }),
        t({ "end", "" }),
    }),
    s({ trig = "header" }, {
        t({ "// ==== " }), i(0), t({ " =======================================================================" })
    }),
    s({ trig = "header_llvm" }, {
        t({ "//===----------------------------------------------------------------------===//", "" }),
        t({ "// " }), i(0), t({ "", "" }),
        t({ "//===----------------------------------------------------------------------===//", "" })
    }),
    s({ trig = "module" }, {
        t({ "module " }), i(1), t({ " #(", "" }),
        t({ ") (", "" }),
        t({ "    input logic clk_i,", ""}),
        t({ "    input logic rst_ni", ""}),
        t({ ");", "" }),
        t({ "  " }), i(0), t({ "", "" }),
        t({ "endmodule", "" })
    }),
}

return M
