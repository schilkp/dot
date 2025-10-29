local M = {}

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

-- stylua: ignore start
M.snippets = {
  s({ trig = "env" }, {
    t("#+begin_"), i(1), t({ "", "" }),
    i(0), t({ "", "" }),
    t("#+end_"), rep(1), t("")
  }),
  s({ trig = "src" }, {
    t("#+begin_src "), i(1), t({ "", "" }),
    i(0), t({ "", "" }),
    t("#+end_src"), t("")
  }),
}
-- stylua: ignore end

return M
