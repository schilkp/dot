local M = {}

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local extras = require("luasnip.extras")
local rep = extras.rep

-- stylua: ignore start
M.snippets = {
  s({ trig = "once" }, {
    t("#ifndef "), i(1), t({ "_H_", "" }),
    t("#define "), rep(1), t({ "_H_", "" }),
    i(0), t({ "", "" }),
    t("#endif /* "), rep(1), t("_H_ */")
  }),
  s({ trig = "ifdef" }, {
    t("#ifdef "), i(1), t({ "", "" }),
    i(0), t({ "", "" }),
    t("#endif /* "), rep(1), t(" */")
  }),
  s({ trig = "ifndef" }, {
    t("#ifndef "), i(1), t({ "", "" }),
    i(0), t({ "", "" }),
    t("#endif /* "), rep(1), t(" */")
  }),
  s({ trig = "dox_brief" }, {
    t("/** @brief "), i(1), t(" */ "), i(0)
  }),
  s({ trig = "dox_line" }, {
    t({ "//!< " }), i(0)
  }),
  s({ trig = "header" }, {
    t({ "// ==== " }), i(0), t({ " =======================================================================" })
  }),
  s({ trig = "header_llvm" }, {
    t({ "//===----------------------------------------------------------------------===//", "" }),
    t({ "// " }), i(0), t({ "", "" }),
    t({ "//===----------------------------------------------------------------------===//", "" })
  }),
  s({ trig = "dox_header" }, {
    t({ "/**", "" }),
    t({ " * @file " }), f(function(_, _) return vim.fs.basename(vim.api.nvim_buf_get_name(0)) end), t({ "", "" }),
    t({ " * @brief " }), i(1), t({ "", "" }),
    t({ " * @author Philipp Schilk, " }), f(function(_, _) return os.date("%Y", os.time()) end), t({ "", "" }),
    t({ " */", "" }),
    i(0)
  }),
  s({ trig = "cpp_extern_c_guard" }, {
    t({ "#ifdef __cplusplus", "" }),
    t({ "extern \"C\" {", "" }),
    t({ "#endif /* __cplusplus */", "" }),
    t({ "", "" }),
    i(0), t({ "", "" }),
    t({ "", "" }),
    t({ "#ifdef __cplusplus", "" }),
    t({ "}", "" }),
    t({ "#endif /* __cplusplus */", "" }),
  }),
  s({ trig = "clang_format_off" }, {
    t({ "// clang-format off", "" }),
  }),
  s({ trig = "clang_format_on" }, {
    t({ "// clang-format on", "" }),
  })
}
-- stylua: ignore end

return M
