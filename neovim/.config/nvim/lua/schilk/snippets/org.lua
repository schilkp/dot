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
    t("MySlide"), t({ "", "" }),
    t("---"), t({ "", "" }),
    t({ "", "" }),
    t("#+end_src"), t({ "", "" }),
    t(""), t({ "", "" }),
  }),
  s({ trig = "presenterm_slide" }, {
    t(""), t({ "", "" }),
    t("<!-- end_slide -->"), t({ "", "" }),
    t("[TITLE]"), t({ "", "" }),
    t("---"), t({ "", "" }),
    t(""), t({ "", "" }),
  }),
  s({ trig = "presenterm_twocol" }, {
    t("<!-- column_layout: [1, 1] -->"), t({ "", "" }),
    t("<!-- column: 0 -->"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("<!-- column: 1 -->"), t({ "", "" }),
    t(""), t({ "", "" }),
    t("<!-- reset_layout -->"), t({ "", "" }),
  }),
  s({ trig = "presenterm_pause" }, {
    t("<!-- pause -->"), t({ "", "" }),
  }),
  s({ trig = "presenterm_newline" }, {
    t("<!-- new_line -->"), t({ "", "" }),
  }),
}
-- stylua: ignore end

return M
