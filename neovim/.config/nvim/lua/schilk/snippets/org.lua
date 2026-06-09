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
  s({ trig = "todo" }, {
    t("[[id:556e377b-a04c-458e-b3d8-94be0fb1f9e4][NOTE_TODO]]"), i(0),
  }),
  s({ trig = "presenterm" }, {
    t("--------------------------------------------------------------------------------"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("** Slides"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("#+begin_src md"), t({ "", "" }),
    t("---"), t({ "", "" }),
    t("title: "), i(0), t({ "", "" }),
    t("author: Philipp Schilk"), t({ "", "" }),
    t("---"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("Customizability"), t({ "", "" }),
    t("---"), t({ "", "" }),
    t("This.."), t({ "", "" }),
    t("<!-- pause -->"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("is a test!"), t({ "", "" }),
    t(""), t({ "", "" }),
    t(""), t({ "", "" }),
    t("<!-- end_slide -->"), t({ "", "" }),
    t("#+end_src"), t({ "", "" }),
    t(""), t({ "", "" }),
  }),
}
-- stylua: ignore end

return M
