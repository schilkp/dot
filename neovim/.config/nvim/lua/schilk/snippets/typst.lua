local M = {}

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- stylua: ignore start
M.snippets = {
  ls.parser.parse_snippet({ trig = "todo_cmd_def" }, [=[
  #let todo(msg) = {
    [#text(fill: red, weight: "bold", size: 12pt)[TODO #msg]]
  }
  ]=]),
  ls.parser.parse_snippet({ trig = "todo" }, [[
  #text(fill: red, weight: "bold", size: 12pt)[TODO]
  ]]),
  ls.parser.parse_snippet({ trig = "fig" }, [[
  #figure(
    image("fig/$1", width: 80%),
    caption: [$0],
  )<$2>
  ]]),

  s({ trig = "comment_llvm" }, {
    t({ "//===----------------------------------------------------------------------===//", "" }),
    t({ "// " }), i(0), t({ "", "" }),
    t({ "//===----------------------------------------------------------------------===//", "" })
  }),
  -- TODO fig dual
  -- TODO table
}
-- stylua: ignore end

return M
