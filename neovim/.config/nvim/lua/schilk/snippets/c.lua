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
    ls.parser.parse_snippet({ trig = "once" }, [[
    #ifndef $1_H_
    #define $1_H_
    $0
    #endif /* $1_H_ */
    ]]),
    ls.parser.parse_snippet({ trig = "ifdef" }, [[
    #ifdef $1
    $0
    #endif /* $1 */
    ]]),
    ls.parser.parse_snippet({ trig = "ifndef" }, [[
    #ifndef $1
    $0
    #endif /* $1 */
    ]]),
    ls.parser.parse_snippet({ trig = "dox_brief" }, [[
    /** @brief $1 */ $0
    ]]),
    ls.parser.parse_snippet({ trig = "dox_line" }, [[
    //!< $0
    ]]),
    s({ trig = "dox_header" }, {
        t({ "/**", "" }),
        t({ " * @file " }), f(function(_, _) return vim.fs.basename(vim.api.nvim_buf_get_name(0)) end), t({ "", "" }),
        t({ " * @brief " }), i(1), t({ "", "" }),
        t({ " * @author Philipp Schilk, " }), f(function(_, _) return os.date("%Y", os.time()) end), t({ "", "" }),
        t({ " */", "" }),
        i(0)
    })
}
return M
